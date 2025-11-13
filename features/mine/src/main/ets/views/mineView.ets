import { BasicButton } from 'basic'

@Component
export struct mineView {
  build() {
    Column() {
      BasicButton({
        message: 'mine'
      })
      Text('我是mine模块')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#ccc')
  }
}