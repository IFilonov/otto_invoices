import Vue from 'vue'
import axios from 'axios'

const token = document.head.querySelector('meta[name="csrf-token"]')
axios.defaults.headers.common['X-CSRF-TOKEN'] = token.content

//использование axios не потребовалось
const adapter = axios.create({
  headers: {
    Accept: 'application/json'
  }
})

const api = {
  xml: {
  }
}

Vue.prototype.$api = api
