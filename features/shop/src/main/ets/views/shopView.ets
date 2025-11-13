import { BasicButton } from 'basic'

@Component
export struct shopView {
  build() {
    Column() {
      BasicButton({
        message: 'shop'
      })
      Text('我是shop模块')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#ccc')
  }
}