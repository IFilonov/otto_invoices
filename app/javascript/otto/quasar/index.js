import Vue from 'vue'
import Quasar from 'quasar'
import 'quasar/dist/quasar.sass'
import iconSet from 'quasar/icon-set/material-icons'
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'
import '@quasar/extras/material-icons/material-icons.css'
import { Notify } from 'quasar'

// фреймворк Quasar используется для отображения общего фрейма и элемента загрузчика файла q-uploader
Vue.use(Quasar, {
    iconSet: iconSet,
    plugins: {
      Notify
    }
})

