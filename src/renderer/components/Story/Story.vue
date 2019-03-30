<template>
  <div v-if="story">
    <!-- parts of the story, i.e. paragraphs -->
    <div class="story__parts">
      <div v-for="(part, i) in storyParts" :key="i"
        :is="part.component"
        v-bind="part.props"
        class="story__part"></div>
    </div>

    <!-- currently available choices -->
    <div class="story__choices">
      <button v-for="choice in storyChoices" :key="choice.index"
        v-html="choice.text"
        @click="choiceClicked(choice)"
        class="story__choice">
      </button>
    </div>

    <!-- dead end -->
    <div v-if="isStoryEnded" class="story__end">
      <button @click="restart" class="story__choice">Restart</button>
    </div>
  </div>
</template>

<script>
import StoryParagraph from './StoryParagraph';
const inkjs = require('inkjs');

export default {
  components: {
    StoryParagraph,
  },
  props: {
    storyContent: null,
  },
  watch: {
    storyContent(newVal) {
      this.story = new inkjs.Story(newVal);

      // start the story
      this.continueStory();
    },
  },
  data() {
    return {
      story: null,
      storyParts: [],
      storyChoices: [],
    };
  },
  computed: {
    isStoryEnded() {
      return this.story.currentChoices.length === 0 && !this.story.canContinue;
    },
  },
  methods: {
    restart() {
      // clear out the current state
      this.story.ResetState();
      this.storyParts = [];
      this.storyChoices = [];

      // begin anew
      this.continueStory();
    },

    continueStory() {
      // while there is available story content...
      while (this.story.canContinue) {
        // generate the next paragraph.
        const paragraphText = this.story.Continue();
        // const tags = this.story.currentTags;

        this.storyParts.push({
          component: StoryParagraph,
          props: {
            content: paragraphText,
          },
        });
      }

      // no more continuations, check for choices.
      this.storyChoices = this.story.currentChoices;
    },

    choiceClicked(choice) {
      // remove all existing choices
      this.storyChoices = [];

      // select the story choice
      this.story.ChooseChoiceIndex(choice.index);

      // continue the story
      this.continueStory();
    },
  },
};
</script>

<style scoped>

.story__choices {
  margin: 1em 0;
}

.story__choice {
  margin: 0.5em;
}

</style>
