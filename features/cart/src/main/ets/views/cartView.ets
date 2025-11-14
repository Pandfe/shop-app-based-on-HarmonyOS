import promptAction from '@ohos.promptAction';
import { BasicButton } from 'basic'

interface CartItemType {
  productId: number
  quantity: number
}

interface ProductType {
  id: number
  categoryId: number
  name: string
  price: number
  image: string
  description: string
}

@Component
export struct cartView {
  @State cartItems: CartItemType[] = [
    { productId: 1, quantity: 2 },
    { productId: 2, quantity: 1 }
  ]
  @State products: ProductType[] = [
    { id: 1, categoryId: 1, name: 'nova 13 Pro', price: 99.99, image: 'https://res2.vmallres.com/pimages/uomcdn/CN/pms/202410/gbom/6942103137129/428_428_CC8A9746DF24D6EA90EF9322630569DCmp.png', description: '超强影像能力' },
    { id: 2, categoryId: 1, name: 'Watch GT 5 Pro', price: 199.99, image: 'https://res4.vmallres.com/pimages/uomcdn/CN/pms/202409/gbom/6942103132216/428_428_9BAD3BCC24D62F134982BB23E027583Bmp.png', description: '最强运动模式' },
    { id: 3, categoryId: 2, name: '商品3', price: 299.99, image: 'https://picsum.photos/200', description: '这是商品3的描述' }
  ]
  @State isLoading: boolean = true

  aboutToAppear() {
    setTimeout(() => {
      this.isLoading = false
    }, 1000)
  }

  clearCart() {
    this.cartItems = []
    promptAction.showToast({ message: '购物车已清空' })
  }

  removeFromCart(productId: number) {
    this.cartItems = this.cartItems.filter(item => item.productId !== productId)
    promptAction.showToast({ message: '商品已移除' })
  }

  getCartTotal() {
    return this.cartItems.reduce((total, item) => {
      const product = this.products.find(p => p.id === item.productId)
      return total + (product ? product.price * item.quantity : 0)
    }, 0)
  }

  build() {
    Column() {
      // BasicButton({
      //   message: 'cart'
      // })
      // Text('我是cart模块')
      //   .fontSize(40)
      //   .fontWeight(FontWeight.Bold)

      // 顶部导航栏
      Row() {
        Text('购物车')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .padding({ left: 24, right: 24 })
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // 购物车列表
      if (this.isLoading) {
        Column() {
          LoadingProgress()
            .width(32)
            .height(32)
          Text('加载中...')
            .fontSize(14)
            .margin({ top: 8 })
            .fontColor('#666666')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      } else if (this.cartItems.length === 0) {
        Column() {
          Image($r('app.media.ic_empty_cart'))
            .width(120)
            .height(120)
            .margin({ bottom: 16 })
          Text('购物车是空的')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 8 })
          Text('快去添加商品吧')
            .fontSize(14)
            .fontColor('#666666')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      } else {
        List({ space: 16 }) {
          ForEach(this.cartItems, (item: CartItemType) => {
            ListItem() {
              Row() {
                Image(this.products.find(p => p.id === item.productId)?.image)
                  .width(80)
                  .height(80)
                  .objectFit(ImageFit.Cover)
                  .margin({ right: 16 })
                  .borderRadius(8)

                Column() {
                  Text(this.products.find(p => p.id === item.productId)?.name)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .margin({ bottom: 4 })
                  Text(this.products.find(p => p.id === item.productId)?.description)
                    .fontSize(12)
                    .fontColor('#666666')
                    .margin({ bottom: 8 })
                  Row() {
                    Text(`¥${this.products.find(p => p.id === item.productId)?.price}`)
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FF0000')
                    Counter() {
                      Text(`${item.quantity}`)
                        .fontSize(14)
                        .fontWeight(FontWeight.Medium)
                        .margin({ left: 12, right: 12 })
                    }
                    .height(28)
                    .backgroundColor('#F5F5F5')
                    .onInc(() => {
                      item.quantity++
                      this.cartItems = [...this.cartItems]
                      promptAction.showToast({ message: '已增加商品数量' })
                    })
                    .onDec(() => {
                      if (item.quantity > 1) {
                        item.quantity--
                        this.cartItems = [...this.cartItems]
                        promptAction.showToast({ message: '已减少商品数量' })
                      } else {
                        this.removeFromCart(item.productId)
                      }
                    })
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Center)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
              }
              .width('100%')
              .padding(8)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .border({ width: 1, color: '#EEEEEE' })
            }
          })
        }
        .layoutWeight(1)
        .padding({ left: 8, right: 8, top: 16, bottom: 16 })
      }

      // 底部结算栏
      if (this.cartItems.length > 0) {
        Row() {
          Column() {
            Text('总计')
              .fontSize(12)
              .fontColor('#666666')
              .margin({ bottom: 2 })
            Text(`¥${this.getCartTotal()}`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF0000')
          }
          .alignItems(HorizontalAlign.Start)

          Button('结算', { type: ButtonType.Normal })
            .width(120)
            .height(40)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .backgroundColor('#007DFF')
            .borderRadius(20)
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ top: 16, bottom: 16, left: 24, right: 24 })
        .backgroundColor('#FFFFFF')
        .border({ width: { top: 0.5 }, color: '#EEEEEE' })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#ccc')
  }
}