<template>
  <div class="story__paragraph" v-html="content"></div>
</template>

<script>
export default {
  props: {
    content: null,
  },
};
</script>

<style scoped>
.story__paragraph {
  margin: 0.5em 0;
}
</style>
