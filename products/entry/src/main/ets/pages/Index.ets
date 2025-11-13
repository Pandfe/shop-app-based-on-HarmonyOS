import { homeView } from 'home'
import { shopView } from 'shop'
import { cartView } from 'cart'
import { mineView } from 'mine'

@Entry
@Component
struct Index {
  build() {
    // 标签栏
    Tabs() {
      TabContent() {
        homeView()
      }
      .tabBar('首页')

      TabContent() {
        shopView()
      }
      .tabBar('商城')

      TabContent() {
        cartView()
      }
      .tabBar('购物车')

      TabContent() {
        mineView()
      }
      .tabBar('我的')
    }
    .width('100%')
    .height('100%')
    .barPosition(BarPosition.End)
  }
}