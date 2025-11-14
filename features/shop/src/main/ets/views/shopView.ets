import promptAction from '@ohos.promptAction';

interface CategoryType {
  id: number
  name: string
}

interface ProductType {
  id: number
  categoryId: number
  name: string
  price: number
  image: string
  description: string
}

interface CartItemType {
  productId: number
  quantity: number
}

@Component
export struct shopView {
  @State currentCategoryId: number = 1
  @State searchText: string = ''
  @State minPrice: number = 0
  @State maxPrice: number = 100000
  @State cartItems: CartItemType[] = []
  @State showCart: boolean = false

  private readonly HEADER_HEIGHT: number = 56
  private readonly SIDEBAR_WIDTH: string = '20%'
  private readonly CART_WIDTH: string = '80%'

  @State categories: CategoryType[] = [
    { id: 1, name: '手机' },
    { id: 2, name: '平板' },
    { id: 3, name: '笔记本' },
    { id: 4, name: '智能穿戴' },
    { id: 5, name: '智能家居' },
    { id: 6, name: '耳机音箱' }
  ]

  @State products: ProductType[] = [
    {
      id: 1,
      categoryId: 1,
      name: 'Mate 60 Pro',
      price: 6999,
      image: 'https://res2.vmallres.com/pimages/FssCdnProxy/vmall_product_uom/pmsSalesFile/800_800_67441C15EA704F11780228434BBCB0EC.png',
      description: '超光变XMAGE影像'
    },
    {
      id: 2,
      categoryId: 2,
      name: 'MatePad Pro 13.2',
      price: 5199,
      image: 'https://res6.vmallres.com/pimages/FssCdnProxy/vmall_product_uom/pmsSalesFile/800_800_D00CAEF274EF4B833B2701B4B3AB39A3.png',
      description: '创作无界 灵感无限'
    },
    {
      id: 3,
      categoryId: 1,
      name: 'Pura 70 Pro',
      price: 5988,
      image: 'https://res7.vmallres.com/pimages/uomcdn/CN/pms/202404/gbom/6942103119088/800_800_42EC40C74080E98F8B3E0799F6602712mp.png',
      description: '超光变XMAGE影像'
    },
    {
      id: 4,
      categoryId: 3,
      name: 'MateBook X Pro',
      price: 10999,
      image: 'https://res5.vmallres.com/pimages/uomcdn/CN/pms/202403/gbom/6942103117060/800_800_B0E613B07478197CE91F1E1D61F3FCB1mp.png',
      description: '13代酷睿处理器'
    },
    {
      id: 5,
      categoryId: 4,
      name: 'WATCH 4 Pro',
      price: 2499,
      image: 'https://res2.vmallres.com/pimages/FssCdnProxy/vmall_product_uom/pmsSalesFile/800_800_098C6A6678FCCD54F16FFCDD4B50DDD6.png',
      description: '运动健康监测'
    },
    {
      id: 6,
      categoryId: 5,
      name: '智慧屏 V5 Pro',
      price: 7999,
      image: 'https://res3.vmallres.com/pimages/uomcdn/CN/pms/202310/gbom/6942103107856/800_800_475CEF27EC9224C5B15D1E88AAC2DC61mp.png',
      description: '4K超高清画质'
    }
  ]

  getFilteredProducts() {
    return this.products
      .filter(product => product.categoryId === this.currentCategoryId)
      .filter(product => product.name.toLowerCase().includes(this.searchText.toLowerCase()))
      .filter(product => product.price >= this.minPrice && product.price <= this.maxPrice)
  }

  getCartTotal() {
    return this.cartItems.reduce((total, item) => {
      const product = this.products.find(p => p.id === item.productId)
      return total + (product ? product.price * item.quantity : 0)
    }, 0)
  }

  addToCart(productId: number) {
    const existingItem = this.cartItems.find(item => item.productId === productId)
    if (existingItem) {
      existingItem.quantity++
      this.cartItems = [...this.cartItems]
    } else {
      this.cartItems.push({ productId, quantity: 1 })
    }
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Text('商城')
          .width('20%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
        Row({ space: 16 }) {
          Search({ value: this.searchText, placeholder: '搜索商品' })
            .layoutWeight(1)
            .height(36)
            .borderRadius(18)
            .backgroundColor('#F5F5F5')
            .onChange((value: string) => {
              this.searchText = value
            })
        }
        .width('80%')
        .padding(8)
      }
      .width('100%')
      .height(this.HEADER_HEIGHT)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // 主内容区
      Row() {
        // 左侧分类导航
        Column() {
          Text('商品分类')
            .padding(16)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 16 })
          List({ space: 8 }) {
            ForEach(this.categories, (category: CategoryType) => {
              ListItem() {
                Text(category.name)
                  .fontSize(14)
                  .fontColor(this.currentCategoryId === category.id ? '#007DFF' : '#666666')
                  .width('100%')
                  .textAlign(TextAlign.Center)
                  .padding(12)
                  .borderRadius(8)
                  .backgroundColor(this.currentCategoryId === category.id ? '#F0F7FF' : '#FFFFFF')
                  .onClick(() => {
                    this.currentCategoryId = category.id
                  })
              }
            })
          }
        }
        .width(this.SIDEBAR_WIDTH)
        .height('100%')
        .padding(6)
        .backgroundColor('#FFFFFF')

        // 右侧内容区
        Column() {
          // 筛选区
          Row() {
            Column() {
              Text('价格区间')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .margin({ bottom: 8 })
              Row() {
                TextInput({ text: this.minPrice.toString(), placeholder: '最低价' })
                  .width('45%')
                  .height(36)
                  .borderRadius(18)
                  .backgroundColor('#F5F5F5')
                  .type(InputType.Number)
                  .textAlign(TextAlign.Center)
                  .onChange((value: string) => {
                    this.minPrice = parseInt(value) || 0
                  })
                Text('-')
                  .fontColor('#666666')
                TextInput({ text: this.maxPrice.toString(), placeholder: '最高价' })
                  .width('45%')
                  .height(36)
                  .borderRadius(18)
                  .backgroundColor('#F5F5F5')
                  .type(InputType.Number)
                  .textAlign(TextAlign.Center)
                  .onChange((value: string) => {
                    this.maxPrice = parseInt(value) || 100000
                  })
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 16, bottom: 16 })
          .backgroundColor('#FFFFFF')

          // 商品列表
          Grid() {
            ForEach(this.getFilteredProducts(), (product: ProductType) => {
              GridItem() {
                Column() {
                  Stack({ alignContent: Alignment.BottomEnd }) {
                    Image(product.image)
                      .width('100%')
                      .aspectRatio(1)
                      .objectFit(ImageFit.Cover)
                      .borderRadius(16)
                      .shadow({ radius: 8, color: '#00000010', offsetX: 0, offsetY: 2 })

                    Button({ type: ButtonType.Circle }) {
                      Image($r('app.media.ic_cart'))
                        .width(20)
                        .height(20)
                        .fillColor('#FFFFFF')
                    }
                    .width(36)
                    .height(36)
                    .margin({ top: 8, right: 8 })
                    .backgroundColor('#007DFF')
                    .shadow({ radius: 8, color: '#00000020', offsetX: 0, offsetY: 2 })
                    .onClick(() => {
                      this.addToCart(product.id)
                    })
                  }
                  .margin({ bottom: 16 })

                  Column() {
                    Text(product.name)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .margin({ bottom: 8 })
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    Text(product.description)
                      .fontSize(14)
                      .fontColor('#666666')
                      .margin({ bottom: 12 })
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    Text(`¥${product.price}`)
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#FF0000')
                  }
                  .alignItems(HorizontalAlign.Start)
                  .width('100%')
                  .padding({ left: 8, right: 8, bottom: 8 })
                }
                .width('100%')
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 12, color: '#00000008', offsetX: 0, offsetY: 4 })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .padding(8)
          .backgroundColor('#F5F5F5')
          .width('100%')
          .height('100%')
        }
        .layoutWeight(1)
        .height('100%')
        .backgroundColor('#F5F5F5')
      }
      .width('100%')
      .height('100%')

      // 购物车侧边栏
      SideBarContainer(SideBarContainerType.Embed) {
        Column() {
          // 购物车标题
          Row() {
            Text('购物车')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
            Button({ type: ButtonType.Circle }) {
              Image($r('app.media.ic_close'))
                .width(20)
                .height(20)
                .fillColor('#666666')
            }
            .width(32)
            .height(32)
            .backgroundColor('#F5F5F5')
            .onClick(() => {
              this.showCart = false
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding({ top: 24, bottom: 24, left: 24, right: 24 })
          .backgroundColor('#FFFFFF')
          .border({ width: { bottom: 0.5 }, color: '#EEEEEE' })

          // 购物车列表
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
                      .borderRadius(14)
                      .onInc(() => {
                        item.quantity++
                        this.cartItems = [...this.cartItems]
                      })
                      .onDec(() => {
                        if (item.quantity > 1) {
                          item.quantity--
                          this.cartItems = [...this.cartItems]
                        } else {
                          this.cartItems = this.cartItems.filter(i => i.productId !== item.productId)
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
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .border({ width: 1, color: '#EEEEEE' })
              }
            })
          }
          .layoutWeight(1)
          .padding({ left: 24, right: 24 })

          // 购物车底部
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
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')
      }
      .showSideBar(this.showCart)
      .sideBarWidth(this.CART_WIDTH)
      .minSideBarWidth(this.CART_WIDTH)
      .maxSideBarWidth(this.CART_WIDTH)
      .autoHide(true)
      .controlButton(null)
    }
    .width('100%')
    .height('100%')
  }
}