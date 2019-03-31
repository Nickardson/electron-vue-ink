<template>
  <div v-if="story">
    <!-- show a background -->
    <div :style="backgroundStyle" class="story__background"></div>

    <div class="story__dialog">
      <!-- show the speaker -->
      <div v-if="characterSpeaking" :style="characterSpeaking.style" class="story__character">
        {{characterSpeaking.name}}
      </div>

      <!-- current paragraph -->
      <story-paragraph v-if="storyParagraph" :content="storyParagraph" class="story__paragraph"></story-paragraph>
    </div>

    <!-- currently available choices -->
    <div v-if="storyChoices.length" class="story__choices">
      <button v-for="choice in storyChoices" :key="choice.index"
        v-html="choice.text"
        @click="choiceClicked(choice)"
        class="story__choice">
      </button>
    </div>

    <!-- continue reading -->
    <div v-if="!isStoryEnded && !storyChoices.length" class="story__choices">
      <button @click="continueStory()"
        class="story__choice">Continue</button>
    </div>

    <!-- dead end -->
    <div v-if="isStoryEnded" class="story__choices story__end">
      <button @click="restart" class="story__choice">Restart</button>
    </div>
  </div>
</template>

<script>
import StoryParagraph from './StoryParagraph';
// import StoryChoiceBreak from './StoryChoiceBreak';
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

      // start the story from scratch
      this.restart();
    },
  },
  data() {
    return {
      story: null,
      storyParagraph: null,
      storyChoices: [],
      backgroundStyle: {},

      characters: {},
      characterSpeaking: null,
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
      this.storyParagraph = null;
      this.storyChoices = [];

      this.characters = {};

      this.story.globalTags.forEach((tag) => {
        const tagStatement = this.splitAction(tag);

        if (!tagStatement.action) {
          return;
        }

        // load a character's properties from a JSON object.
        if (tagStatement.action.toUpperCase().startsWith('CHARACTER')) {
          const newCharacterName = tagStatement.action.split(' ')[1];
          this.characters[newCharacterName] = JSON.parse(tagStatement.value);
        }
      });

      // begin anew
      this.continueStory();
    },

    continueStory() {
      // if there is available story content...
      if (this.story.canContinue) {
        // generate the next paragraph.
        const paragraphText = this.story.Continue();
        const tags = this.story.currentTags;

        tags.forEach((tag) => {
          const tagStatement = this.splitAction(tag);

          if (!tagStatement.action) {
            return;
          }

          // apply a background style by parsing a JSON object into CSS properties.
          // you could just as easily apply a class, or show a different element.
          if (tagStatement.action.toUpperCase() === 'BACKGROUND') {
            this.backgroundStyle = JSON.parse(tagStatement.value);
          }
        });

        // determine who is speaking.
        const statement = this.splitAction(paragraphText);

        if (statement.action !== null) {
          // spoken by a character, i.e. "Bob: Hello!"
          this.characterSpeaking = this.characters[statement.action];
        } else {
          // spoken by a narrator, i.e. "And thus it began."
          this.characterSpeaking = null;
        }

        this.storyParagraph = statement.value;
      } else {
        // can't continue, we may be at a choice.
        this.storyChoices = this.story.currentChoices;

        // we could clear the current text...
        // this.storyParagraph = null;
      }
    },

    choiceClicked(choice) {
      // remove all existing choices
      this.storyChoices = [];

      // select the story choice
      this.story.ChooseChoiceIndex(choice.index);

      // continue the story
      this.continueStory();
    },

    splitAction(text) {
      const firstSplit = text.indexOf(':');

      // no match means no action, just a value
      if (firstSplit === -1) {
        return {
          action: null,
          value: text,
        };
      }

      // we got a match, split i.e. "ACTION: value"
      const action = text.substring(0, firstSplit).trim();
      const value = text.substring(firstSplit + 1).trim();

      return {
        action,
        value,
      };
    },
  },
};
</script>

<style scoped>
.story__background {
  width: 100%;
  height: 200px;
}

.story__dialog {
  display: flex;
  align-items: center;
}

.story__character {
  padding: 0.5em;
  margin: 0.5em;
  border-radius: 0.2em;
}

.story__choices {
  margin: 1em 0;
}

.story__choice {
  margin: 0.5em;
}

</style>
