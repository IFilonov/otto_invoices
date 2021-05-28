import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Loader from '../components/loader';

export default new VueRouter( {
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/', redirect: '/otto/loader'},
    { path: '/otto/loader', component: Loader, name: 'Loader'}
  ]
})