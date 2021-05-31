import Vue from 'vue'
import App from '../otto/components/xml.vue'
import '../otto/quasar'
import '../otto/api'
import router from '../otto/router'
import store from '../otto/store'

document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
        render: h => h(App),
        router: router,
        store
    }).$mount()
    document.body.appendChild(app.$el)
})
