<template lang="pug">
  div
    q-layout
      q-header(elevated class="bg-grey-6 text-white")
        q-toolbar(class="glossy")
          q-toolbar-title
            span {{ title }}
      q-drawer(show-if-above bordered side="left" behavior="desktop" elevated)
        q-list(bordered padding class="text-grey-7 text-bold")
          q-item(clickable v-ripple active-class="my-menu-link" :to="{ name: 'Loader'}")
            q-item-section(avatar)
              q-icon(name="fas fa-cubes")
            q-item-section
              q-item-label Loader
      q-page-container
        router-view
</template>

<script>
export default {
  data: function () {
    return {
      title: "XML loader"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
