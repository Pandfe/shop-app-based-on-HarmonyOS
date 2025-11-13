import { BasicButton } from 'basic'

@Component
export struct cartView {
  build() {
    Column() {
      BasicButton({
        message: 'cart'
      })
      Text('我是cart模块')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#ccc')
  }
}