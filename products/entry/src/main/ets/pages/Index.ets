import { homeView } from 'home'
import { shopView } from 'shop'
import { cartView } from 'cart'
import { mineView } from 'mine'

interface TabClass {
  text: string
  icon: ResourceStr
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0

  tabData: TabClass[] = [
    {
      text: '首页',
      icon: $r('app.media.ic_index')
    },
    {
      text: '商城',
      icon: $r('app.media.ic_shop')
    },
    {
      text: '购物车',
      icon: $r('app.media.ic_shop_cart')
    },
    {
      text: '我的',
      icon: $r('app.media.ic_mine')
    }
  ]

  @Builder tabBuilder(item: TabClass, index: number) {
    Column({ space: 5 }) {
      Image(item.icon)
        .width(24)
        .fillColor(this.currentIndex === index ? '#E85A88' : '#606266')
      Text(item.text)
        .fontSize(14)
        .fontColor(this.currentIndex === index ? '#E85A88' : '#606266')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      // 主要内容区域
      Column() {
        if (this.currentIndex === 0) {
          homeView()
        } else if (this.currentIndex === 1) {
          shopView()
        } else if (this.currentIndex === 2) {
          cartView()
        } else if (this.currentIndex === 3) {
          mineView()
        }
      }
      .layoutWeight(1)
      .width('100%')

      // 底部导航栏
      Row() {
        ForEach(this.tabData, (item: TabClass, index: number) => {
          Column() {
            this.tabBuilder(item, index)
          }
          .layoutWeight(1)
          .height(60)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.currentIndex = index
          })
        })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .border({
        width: { top: 1 },
        color: '#EEEEEE'
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}