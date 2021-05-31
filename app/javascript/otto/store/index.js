import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

//использование vuex только в части хранения адреса хоста, в продакшене используется ENV
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
