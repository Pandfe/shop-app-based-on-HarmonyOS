import { BasicButton } from 'basic'


@Component
export struct homeView {
  build() {

    Column() {
      BasicButton({
        message: 'home'
      })
      Text('我是home模块')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#ccc')
  }
}