@Component
export struct BasicButton {
  @Prop message: string = 'basic'

  build() {
    Button('我是basic模块的通用组件')
      .backgroundColor('#F97130')
      .onClick(() => {
        AlertDialog.show({
          message: `我在${this.message}模块用到`
        })
      })
  }
}