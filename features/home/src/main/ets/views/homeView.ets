import { BasicButton } from 'basic'

interface recommendDailyType {
  img: string
  title: string
  type: string
  top: string
  bottom: string
}

interface recommendListType {
  img: string
  title: string
  count: string
}

@Component
export struct homeView {
  swiperList: string[] = [
    'https://res.vmallres.com/uomcdn/CN/cms/202503/9ae8c1003f1945e69ebb7c44c5f05372.jpg',
    'https://res.vmallres.com/uomcdn/CN/cms/202503/5da58a182a6146f5af3ecb90d3c54c27.png',
    'https://res.vmallres.com/uomcdn/CN/cms/202504/2f3e4d6b082444d3b1624dd647edc188.jpg',
    'https://res.vmallres.com/uomcdn/CN/cms/202503/ada63d50b41043079909b41ffc6ec9a1.jpg'
  ]

  hotRecommend: recommendDailyType[] = [
    {
      img: 'https://res3.vmallres.com/pimages/uomcdn/CN/pms/202403/gbom/6942103109966/428_428_355A5C68D5AA879C92A5A25E16C4B10Fmp.png',
      title: '华为 Mate 60',
      type: '每日爆品',
      top: '#660000',
      bottom: '#382e2f'
    },
    {
      img: 'https://res5.vmallres.com/pimages/uomcdn/CN/pms/202404/gbom/6942103119095/428_428_03DDA608E3C79BBBE982E3D3367A4EB6mp.png',
      title: '华为 Pura 70',
      type: '每日爆品',
      top: '#660000',
      bottom: '#382e2f'
    },
    {
      img: 'https://res4.vmallres.com/pimages/FssCdnProxy/vmall_product_uom/pmsSalesFile/428_428_B0E229328D2E5438A2BD9AD5E068ECE7.png',
      title: '华为 Mate 70',
      type: '每日爆品',
      top: '#660000',
      bottom: '#382e2f'
    },
    {
      img: 'https://res8.vmallres.com/pimages/FssCdnProxy/vmall_product_uom/pmsSalesFile/428_428_690BCA14052ADF44529C036EE4430552.png',
      title: '华为 Mate X6',
      type: '每日爆品',
      top: '#660000',
      bottom: '#382e2f'
    },
    {
      img: 'https://res.vmallres.com/uomcdn/CN/cms/202501/b2fa0296ec1e4545b218c80c2098d01b.png',
      title: 'HUAWEI FreeClip 耳夹耳机',
      type: '每日爆品',
      top: '#660000',
      bottom: '#382e2f'
    }
  ]

  fashionList: recommendListType[] = [
    {
      img: 'https://res.vmallres.com/uomcdn/CN/cms/202504/6ffd0aa7b55242dfaf3bc09e426c2907.png',
      title: '哈曼卡顿音响',
      count: '2000万'
    },
    {
      img: 'https://res.vmallres.com/uomcdn/CN/cms/202501/595449ccd29c4641b78b85ecaa83161b.png',
      title: '华为 MateBook Pro 2025',
      count: '2000万'
    },
    {
      img: 'https://res.vmallres.com/uomcdn/CN/cms/202504/00700421dab949fb9c56417e13de3f1a.png',
      title: '华为智慧屏',
      count: '2000万'
    },
    {
      img: 'https://res.vmallres.com/uomcdn/CN/cms/202501/b2fa0296ec1e4545b218c80c2098d01b.png',
      title: 'HUAWEI FreeClip 耳夹耳机',
      count: '2000万'
    }
  ]

  @Builder
  titleBuilder(title: string) {
    Row() {
      Text(title)
        .fontColor('#000')
        .fontWeight(700)
        .layoutWeight(1)
      Image($r('app.media.ic_more'))
        .width(22)
        .fillColor('#000')
    }
    .width('100%')
    .height(50)
  }

  build() {
    Scroll() {
      Column({ space: 10 }) {
        // 搜索区域
        Row() {
          Image($r('app.media.ic_search'))
            .width(22)
            .fillColor('#817D83')
          TextInput({ placeholder: '华为 Pura X🔥'})
            .placeholderColor('#817D83')
            .padding({
              left: 5
            })
            .backgroundColor('#fff')
            .fontColor('#999')
            .layoutWeight(1)
          Image($r('app.media.ic_code'))
            .width(20)
            .fillColor('#817D83')
        }
        .width('100%')
        .backgroundColor('#fff')
        .border({
          radius: 20
        })
        .padding({
          left: 8,
          right: 8
        })
        // 轮播图区域
        Swiper() {
          ForEach(this.swiperList, (item: string) => {
            Image(item)
              .width('100%')
              .border({
                radius: 10
              })
          })
        }
        .autoPlay(true)
        // 爆品推荐区域
        this.titleBuilder('爆品推荐')
        List() {
          ForEach(this.hotRecommend, (item: recommendDailyType) => {
            ListItem() {
              Column() {
                Text(item.type)
                  .width('100%')
                  .height(40)
                  .backgroundColor(item.top)
                  .padding({
                    left: 5
                  })
                  .fontSize(14)
                  .fontColor('#fff')
                Image(item.img)
                  .width('100%')
                Text(item.title)
                  .width('100%')
                  .backgroundColor(item.bottom)
                  .padding(5)
                  .fontSize(14)
                  .fontColor('#fff')
                  .maxLines(2)
                  .textOverflow({
                    overflow: TextOverflow.Ellipsis
                  })
              }
              .width('40%')
              .border({
                width: 1,
                radius: 10
              })
              .margin({
                right: 10
              })
              .clip(true)
            }
          })
        }
        .listDirection(Axis.Horizontal)
        .height(230)
        .scrollBar(BarState.Off)
        // 时尚单品
        this.titleBuilder('时尚单品')
        List() {
          ForEach(this.fashionList, (item: recommendListType) => {
            ListItem() {
              Column() {
                Stack({
                  alignContent: Alignment.TopStart
                }) {
                  Image(item.img)
                    .width('100%')
                    .height(100)
                    .border({
                      radius: 8
                    })
                  Text(item.count)
                    .fontColor('#000')
                    .fontSize(12)
                    .fontWeight(700)
                    .margin(5)
                }
                Text(item.title)
                  .fontColor('#000')
                  .fontSize(14)
                  .width('100%')
                  .padding(5)
                  .maxLines(2)
                  .textOverflow({
                    overflow: TextOverflow.Ellipsis
                  })
              }
              .width('30%')
              .backgroundColor(Color.White)
              .border({
                radius: 10
              })
              .margin({
                right: 10
              })
            }
          })
        }
        .listDirection(Axis.Horizontal)
        .height(230)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .padding({
        left: 10,
        right: 10,
        top: 5,
        bottom: 5
      })
    }
  }
}