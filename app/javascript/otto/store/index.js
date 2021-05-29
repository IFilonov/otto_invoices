import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store(  {
  state: {
    host: "http://localhost:3000/api/batch_files"
  },
  getters: {
    host: (state) => {
      return state.host
    }
  },
  actions: {
  }
})
