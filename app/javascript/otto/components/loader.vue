<template lang="pug">
  div(class="q-pa-md")
    q-uploader(label="Upload"
      accept=".xml"
      :factory="factoryFn"
      @failed="failedFn"
      @uploaded="uploadedFn"
      field-name="invoice_file"
      style="max-width: 300px")
      template(v-slot:list="scope")
        q-list(separator)
          q-item(v-for="file in scope.files" :key="file.name")
            q-item-section
              q-item-label(class="full-width ellipsis") {{ file.name }}
              q-item-label(caption) Status: {{ file.__status }}
              q-item-label(caption) {{ file.__sizeLabel }} / {{ file.__progressLabel }}
            q-item-section(
              v-if="file.__img"
              thumbnail
              class="gt-xs")
              img(:src="file.__img.src")
            q-item-section(top side)
              q-btn(class="gt-xs"
                size="12px"
                flat
                dense
                round
                icon="delete"
                @click="scope.removeFile(file)")
</template>

<script>
import {mapGetters} from 'vuex'
export default {
  data: function () {
    return {}
  },
  computed: {
    ...mapGetters(['host'])
  },
  methods: {
    factoryFn (file) {
      return new Promise((resolve, reject) => {
        const token = document.head.querySelector('meta[name="csrf-token"]');
        resolve({
          url: this.host,
          method: 'POST',
          headers: [
            { name: 'X-CSRF-TOKEN', value: token.content },
          ]
        })
      })
    },
    failedFn(info) {
      this.$q.notify({
        type: 'negative',
        message: `Ошибка загрузки файла. Детально: ${info.xhr.responseText.substring(1, 500)}`
      })
    },
    uploadedFn(info) {
      this.$q.notify({
        type: 'positive',
        message: `Файл ${info.files[0].name.substring(1, 500)} успешно загружен!`
      })
    }
  }
}
</script>
