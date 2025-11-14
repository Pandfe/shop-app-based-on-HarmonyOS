import promptAction from '@ohos.promptAction';
import { BasicButton } from 'basic'

interface UserInfo {
  avatar: string
  nickname: string
  level: string
}

interface MenuItem {
  icon: Resource
  title: string
  badge?: number
}

@Component
export struct mineView {
  @State userInfo: UserInfo = {
    avatar: 'https://picsum.photos/200',
    nickname: '鸿蒙用户',
    level: '普通会员'
  }

  @State orderMenus: MenuItem[] = [
    { icon: $r('app.media.ic_will_pay'), title: '待付款', badge: 2 },
    { icon: $r('app.media.ic_will_send'), title: '待发货', badge: 1 },
    { icon: $r('app.media.ic_will_get'), title: '待收货' },
    { icon: $r('app.media.ic_finish'), title: '已完成' },
    { icon: $r('app.media.ic_back_fix'), title: '退换/售后' }
  ]

  @State functionMenus: MenuItem[] = [
    { icon: $r('app.media.ic_address'), title: '收货地址' },
    { icon: $r('app.media.ic_coupon'), title: '优惠券' },
    { icon: $r('app.media.ic_collect'), title: '收藏夹' },
    { icon: $r('app.media.ic_histroy'), title: '浏览记录' }
  ]

  @State serviceMenus: MenuItem[] = [
    { icon: $r('app.media.ic_consert'), title: '客服中心' },
    { icon: $r('app.media.ic_help'), title: '帮助中心' },
    { icon: $r('app.media.ic_settings'), title: '设置' }
  ]

  @Builder MenuGrid(menus: MenuItem[]) {
    Grid() {
      ForEach(menus, (item: MenuItem) => {
        GridItem() {
          Column() {
            Stack() {
              Image(item.icon)
                .width(32)
                .height(32)
              if (item.badge) {
                Text(`${item.badge}`)
                  .width(15)
                  .height(15)
                  .fontSize(10)
                  .fontColor('#FFFFFF')
                  .backgroundColor('#FF0000')
                  .borderRadius(8)
                  .textAlign(TextAlign.Center)
                  .position({ x: 20, y: -4 })
              }
            }
            .width(32)
            .height(32)
            .margin({ bottom: 4 })

            Text(item.title)
              .fontSize(12)
              .fontColor('#333333')
          }
          .onClick(() => {
            promptAction.showToast({ message: `点击了${item.title}` })
          })
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
    .rowsGap(16)
    .columnsGap(8)
    .padding(16)
  }

  build() {
    Column() {
      // BasicButton({
      //   message: 'mine'
      // })
      // Text('我是mine模块')
      //   .fontSize(40)
      //   .fontWeight(FontWeight.Bold)

      // 顶部导航栏
      Row() {
        Text('我的')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // 主要内容区域
      Scroll() {
        Column() {
          // 用户信息卡片
          Row() {
            Row() {
              Image(this.userInfo.avatar)
                .width(64)
                .height(64)
                .borderRadius(32)
                .margin({ right: 16 })

              Column() {
                Text(this.userInfo.nickname)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 4 })
                Text(this.userInfo.level)
                  .fontSize(12)
                  .fontColor('#666666')
                  .backgroundColor('#F5F5F5')
                  .borderRadius(10)
                  .padding({ left: 8, right: 8, top: 2, bottom: 2 })
              }
              .alignItems(HorizontalAlign.Start)
            }

            Image($r('app.media.ic_right_arrow'))
              .width(24)
              .height(24)
              .fillColor('#E85A88')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // 我的订单
          Column() {
            Row() {
              Text('我的订单')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
              Row({
                space: 5
              }) {
                Text('查看全部')
                  .fontSize(12)
                  .fontColor('#666666')
                Image($r('app.media.ic_all'))
                  .width(16)
                  .height(16)
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding({ left: 16, right: 16, top: 16 })

            this.MenuGrid(this.orderMenus)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .margin({ top: 12 })

          // 常用功能
          Column() {
            Text('常用功能')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .padding({ left: 16, top: 16 })

            this.MenuGrid(this.functionMenus)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .margin({ top: 12 })

          // 更多服务
          Column() {
            Text('更多服务')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .padding({ left: 16, top: 16 })

            List() {
              ForEach(this.serviceMenus, (item: MenuItem) => {
                ListItem() {
                  Row() {
                    Row() {
                      Image(item.icon)
                        .width(24)
                        .height(24)
                        .margin({ right: 8 })
                      Text(item.title)
                        .fontSize(14)
                    }
                    Image($r('app.media.ic_right_arrow'))
                      .width(16)
                      .height(16)
                  }
                  .width('100%')
                  .padding(16)
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Center)
                  .onClick(() => {
                    promptAction.showToast({ message: `点击了${item.title}` })
                  })
                }
              })
            }
            .divider({ strokeWidth: 0.5, color: '#EEEEEE' })
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .margin({ top: 12, bottom: 24 })
        }
        .padding({ left: 8, right: 8 })
      }
      .layoutWeight(1)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#ccc')
  }
}