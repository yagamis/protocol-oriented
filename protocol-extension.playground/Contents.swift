

protocol 钱庄: BooleanType {
    var 名称 : String { get }
    var 可存款 : Bool { get }
}

extension BooleanType where Self: 钱庄 {
    var boolValue: Bool {
        return self.可存款
    }
}

protocol 可存款 {
    var 利息: Double { get }
}

struct 银行: 钱庄, 可存款 {
    let 名称: String
    
    let 本金: Double
    let 利率: Double
    
    
    
    var 利息: Double {
        return 利率 + 0.1
    }
}

struct 基金: 钱庄 {
    let 名称: String
    let 可存款 = false
}

struct 支付宝: 钱庄, 可存款 {
    var 版本: String
    var 名称: String { return "支付宝 \(版本)"}
   
    
    //收益年化率惊人
    var 利息: Double { return 0.9 }
}

extension 钱庄 where Self: 可存款 {
    var 可存款: Bool { return true }
}


enum 微信钱包: 钱庄, 可存款 {
    case 刷卡
    case 转账
    case 打车
    case 理财
    
    var 名称: String {
      switch self {
        case .刷卡 :
            return "请输入支付密码："
        case .转账:
            return "请输入对方微信号："
        case .理财:
            return "请选择理财产品："
        case .打车:
            return "请选择出行时间："
       }
    }
    
    var 利息: Double {
        switch self {
        case .理财:
            return 0.85
        default:
            return 0.0
        }
    }
}

extension CollectionType {
    func skip(skip: Int) -> [Generator.Element] {
        guard skip != 0 else { return [] }
        
        var index = self.startIndex
        var result: [Generator.Element] = []
        var i = 0
        repeat {
            if i % skip == 0 {
                result.append(self[index])
            }
            index = index.successor()
            i++
        } while (index != self.endIndex)
        
        return result
    }
}


let 各种宝: [钱庄] = [
    基金(名称: "天弘基金"),
    银行(名称: "招商银行", 本金: 10_000, 利率: 0.5),
    支付宝(版本: "2.0余额宝"),
    微信钱包.打车,
    微信钱包.刷卡,
    微信钱包.理财,
    微信钱包.转账
]

各种宝.skip(2)

if 微信钱包.转账 {
    print("oh yeah,可以存我这！可以转账！")
} else {
    print("额，对不起，还不能存钱到我这。。呜呜")
}

let 数字集合:Set = [10,1,2,3,4,5]
let 有余数的元素个数 = 数字集合.map{ $0 % 2 }.filter{ $0 == 1 }.reduce(0) { $0 + $1}
//有余数的元素个数 ： 3

func 最高利息<T: CollectionType where T.Generator.Element == 可存款 >(collection: T) -> Double {
    return collection.map{ $0.利息 }.reduce(0){max($0, $1)}
}

let 存钱宝 :[可存款] = [
    微信钱包.理财,
    微信钱包.转账,
    支付宝(版本: "2.0余额宝")
]

最高利息(存钱宝) //0.9

