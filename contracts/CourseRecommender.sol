//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CourseRecommender {
    
    struct Rating {
        uint256 rating;
        bool exists;
    }
    
    mapping(address => mapping(uint256 => Rating)) public ratings;
    mapping(address => uint256[]) public ratedCourses;
    mapping(uint256 => mapping(address => bool)) private courseRaters;
    mapping(address => uint256[]) private recommendations;
    
    function rateCourse(uint256 courseId, uint256 rating) public {
        require(courseId > 0, "Invalid course id");
        require(rating >= 1 && rating <= 5, "Invalid rating");
        
        Rating storage userRating = ratings[msg.sender][courseId];
        if (!userRating.exists) {
            ratedCourses[msg.sender].push(courseId);
        }
        userRating.rating = rating;
        userRating.exists = true;
        
        courseRaters[courseId][msg.sender] = true;
    }
    
    function getRecommendations() public returns (uint256[] memory) {
        uint256[] storage recs = recommendations[msg.sender];
        if (recs.length == 0) {
            uint256[] memory similarities = new uint256[](ratedCourses[msg.sender].length);
            for (uint256 i = 0; i < ratedCourses[msg.sender].length; i++) {
                uint256 courseId = ratedCourses[msg.sender][i];
                address[] memory raters = getCourseRaters(courseId);
                for (uint256 j = 0; j < raters.length; j++) {
                    address rater = raters[j];
                    if (rater != msg.sender && ratings[rater][courseId].exists) {
                        uint256 similarity = getSimilarity(msg.sender, rater);
                        similarities[i] += similarity;
                        recs.push(0); // initialize the recommended rating for this course
                        recs[recs.length - 1] += ratings[rater][courseId].rating * similarity; // update the recommended rating for this course
                    }
                }
            }
            for (uint256 i = 0; i < recs.length; i++) {
                recs[i] /= similarities[i / ratedCourses[msg.sender].length]; // normalize the recommended ratings
            }
            sortRecommendations(recs);
        }
        return recs;
    }
    
    function getCourseRaters(uint256 courseId) private view returns (address[] memory) {
        uint256 len = 0;
        for (uint256 i = 0; i < ratedCourses[msg.sender].length; i++) {
            if (ratedCourses[msg.sender][i] == courseId) {
                len++;
            }
        }
        address[] memory result = new address[](len);
        uint256 index = 0;
        for (uint256 i = 0; i < ratedCourses[msg.sender].length; i++) {
            if (ratedCourses[msg.sender][i] == courseId) {
                result[index] = address(msg.sender);
                index++;
            }
        }
        return result;
    }
    
    function getSimilarity(address a, address b) private view returns (uint256) {
        uint256 similarity = 0;
        uint256 numRatings = 0;
        for (uint256 i = 0; i < ratedCourses[a].length; i++) {
            uint256 courseId = ratedCourses[a][i];
            if (ratings[b][courseId].exists) {
                similarity += ratings[a][courseId].rating * ratings[b][courseId].rating;
                numRatings++;
            }
        }
        if (numRatings == 0) {
            return 0;
    } else {
        uint256 denominator = getMagnitude(a) * getMagnitude(b);
        return denominator == 0 ? 0 : (similarity * 10000) / denominator;
    }
}

function getMagnitude(address user) private view returns (uint256) {
    uint256 magnitude = 0;
    for (uint256 i = 0; i < ratedCourses[user].length; i++) {
        uint256 courseId = ratedCourses[user][i];
        Rating storage rating = ratings[user][courseId];
        if (rating.exists) {
            magnitude += rating.rating * rating.rating;
        }
    }
    return sqrt(magnitude);
}

function sortRecommendations(uint256[] storage recs) private {
    for (uint256 i = 0; i < recs.length - 1; i++) {
        for (uint256 j = i + 1; j < recs.length; j++) {
            if (recs[j] > recs[i]) {
                (recs[i], recs[j]) = (recs[j], recs[i]);
            }
        }
    }
}

function sqrt(uint256 x) private pure returns (uint256 y) {
    uint256 z = (x + 1) / 2;
    y = x;
    while (z < y) {
        y = z;
        z = (x / z + z) / 2;
    }
}
}
