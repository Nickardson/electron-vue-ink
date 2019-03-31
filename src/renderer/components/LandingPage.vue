<template>
  <div id="wrapper">
    <img id="logo" src="~@/assets/logo.png" alt="electron-vue">
    <main>
      <div class="left-side">
        <stacked-story v-if="storyLayout === 'stacked'" :storyContent="storyContent"></stacked-story>
        <conversation-story v-if="storyLayout === 'conversation'" :storyContent="storyContent"></conversation-story>
      </div>

      <div class="right-side">
        <div class="title">Welcome to your new project!</div>

        <button @click="loadInkFileAsStacked('static/ink/cyclical.ink.json')">Stacked Cyclical Sample</button>
        <button @click="loadInkFileAsStacked('static/ink/tunnels.ink.json')">Stacked Tunnels Sample</button>

        <br/><br/>
        <button @click="loadInkFileAsConversation('static/ink/conversational.ink.json')">Conversation Styled Sample</button>

        <system-information></system-information>

        <div class="doc">
          <div class="title">Getting Started</div>
          <p>
            electron-vue comes packed with detailed documentation that covers everything from
            internal configurations, using the project structure, building your application,
            and so much more.
          </p>
          <button
            @click="open('https://simulatedgreg.gitbooks.io/electron-vue/content/')"
          >Read the Docs</button>
          <br>
          <br>
        </div>
        <div class="doc">
          <div class="title alt">Other Documentation</div>
          <button class="alt" @click="open('https://electron.atom.io/docs/')">Electron</button>
          <button class="alt" @click="open('https://vuejs.org/v2/guide/')">Vue.js</button>
        </div>
      </div>
    </main>
  </div>
</template>

<script>
import axios from 'axios';

import SystemInformation from './LandingPage/SystemInformation';
import StackedStory from './Story/StackedStory';
import ConversationStory from './Story/ConversationStory';

export default {
  name: 'landing-page',
  components: {
    SystemInformation,
    StackedStory,
    ConversationStory,
  },
  data: () => ({
    storyContent: null,
    storyLayout: 'stacked',
  }),
  mounted() {
    this.loadInkFile('static/ink/cyclical.ink.json');
  },
  methods: {
    loadInkFile(filePath) {
      axios
        .get(filePath)
        .then((response) => {
          this.storyContent = response.data;
        });
    },

    loadInkFileAsStacked(filePath) {
      this.storyLayout = 'stacked';
      this.loadInkFile(filePath);
    },

    loadInkFileAsConversation(filePath) {
      this.storyLayout = 'conversation';
      this.loadInkFile(filePath);
    },

    open(link) {
      this.$electron.shell.openExternal(link);
    },
  },
};
</script>

<style>
@import url("https://fonts.googleapis.com/css?family=Source+Sans+Pro");

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: "Source Sans Pro", sans-serif;
}

#wrapper {
  background: radial-gradient(
    ellipse at top left,
    rgba(255, 255, 255, 1) 40%,
    rgba(229, 229, 229, 0.9) 100%
  );
  min-height: 100vh;
  padding: 60px 80px;
}

#logo {
  height: auto;
  margin-bottom: 20px;
  width: 420px;
}

main {
  display: flex;
  justify-content: space-between;
}

main > div {
  flex-basis: 50%;
}

.left-side {
  display: flex;
  flex-direction: column;
  padding: 1em;
}

.welcome {
  color: #555;
  font-size: 23px;
  margin-bottom: 10px;
}

.title {
  color: #2c3e50;
  font-size: 20px;
  font-weight: bold;
  margin-bottom: 6px;
}

.title.alt {
  font-size: 18px;
  margin-bottom: 10px;
}

.doc p {
  color: black;
  margin-bottom: 10px;
}

button {
  font-size: 0.8em;
  cursor: pointer;
  outline: none;
  padding: 0.75em 2em;
  border-radius: 2em;
  display: inline-block;
  color: #fff;
  background-color: #4fc08d;
  transition: all 0.15s ease;
  box-sizing: border-box;
  border: 1px solid #4fc08d;
}

button.alt {
  color: #42b983;
  background-color: transparent;
}
</style>
