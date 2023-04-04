<!-- App.svelte -->
<script>
  import { Router, Route } from "svelte-routing";

  // Admin Layout
  import Admin from "./layouts/Admin.svelte";
  import Instructor from "./layouts/instructor.svelte";
  import Course from "./layouts/Course.svelte";
  // Auth Layout
  import Auth from "./layouts/Auth.svelte";

  // No Layout Pages
  import Index from "./views/Index.svelte";
  import Landing from "./views/Landing.svelte";
  import Profile from "./views/Profile.svelte";
  import IProfile from "./views/IProfile.svelte";

  export let url = "";
</script>

<Router url="{url}">
  <!-- admin layout -->
  <Route path="admin/*admin" component="{Admin}" />
  <Route path="instructor/*instructor" component={Instructor}/>
  <Route path="course/*course" component={Course}/>
  <!-- auth layout -->
  <Route path="auth/*auth" component="{Auth}" />
  <!-- no layout pages -->
  <Route path="landing" component="{Landing}" />
  <Route path="profile" component="{Profile}" />
  <Route path="iprofile" component="{IProfile}" />
  <Route path="/" component="{Index}" />
</Router>
