//
//  MessageModel.swift
//  IMxyb
//
//  Created by Elise on 16/4/21.
//  Copyright © 2016年 Elise. All rights reserved.
//

import Foundation

internal var AllMessageData:[MessageModel] = []









let NameArray:[String] = ["Fur","EASON","Jay","Strasbourg","点赞狂魔","Nothing","John Doe","五分熟煎蛋","献给Alice","Flint","一五九零","假装在纽约","Tracy六瓣丁香","Swift","April在厨房","漠北","故事细腻","Jon Snow","WAlbum","一九八三年","于小壳","Doge脸","团子"]
let IconArray:[String] = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]

let MessageArray:[String] = [
    "Excuse me???????????",
    "请问下有没有卖半岛铁盒?",
    "有啊，你从前面右转的第二排架子上就有了",
    "什么事？🐂🐂🐂🐂",
    "好好地，🐂别瞎胡闹",
    "Brainy is the new sexy",
    "呵呵🐎🐎🐎🐎🐎🐎",
    "不懂",
    "你谁？？？🐎🐎🐎🐎",
    "好好好~~~",
    "Epilogue",
    "没什么事",
    "You konw nothing Jon Snow",
    "emoji~😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊😊",
    "when you look long into an abyss,the abyss looks into you",
    "Do not go gentle into that good night",
    "We can easily forgive a child who is afraid of the dark; the real tragedy of life is when men are afraid of the light. ———— Plato",
    "What though the radiance which was once so bright,Be now for ever taken from my sight,Though nothing can bring back the hourOf splendour in the grass, of glory in the flower;We will grieve not, rather findStrength in what remains behind——William Wordsworth",
    "Try again. Fail again. Fail better.——Samuel Beckett",
    "Men heap together the mistakes of their lives and create a monster they call destiny.--John Hobbes",
    "While nothing is easier than to denounce the evildoer, nothing is more difficult than to understand him.——Feodor Mikhailovich Dostoyevsky",
    "下雨了☔️",
     "雨停了☔️",
     "又下雨了☔️",
     "？？？？？？？？？？？？？？？",
     "咱听不懂你说什么",
     "啥啥啥？",
    "上海植物园里有一棵元宝枫，在温室的前边我大学时和寝室同学去植物园野餐，路过这棵树。那会儿还是比较寒冷的冬季，它并没有展现出让人留意的特质。所以即使在它的不远处拍过合照，它也没有在我记忆里留下太深的印象。很多植物和很多人就是这样，在一个时间段里，它们如此默默无闻。你走过，也不会抬头去看它的躯干与肢体。而树木恰好是那种可以去长期在意、更为固定的存在体",
    "后来我去植物园的次数变得越来越多，有事没事都会去植物园闲逛。熟悉了之后，就会知道某一种植物出现在哪里，用植物系的地图来区分植物园的区域。这棵元宝枫是植物园很突出的一棵树，栽在广场上，大而繁盛。",
    "每到夏天，烈日当头，我就站在这棵元宝枫下休息乘凉，擦干汗水然后继续拍那些烈日下阴影过于深重的花与果。那会儿它是绿色的，宽大的手臂就在我的头顶上，像一个星系的巨网，脉络里是透着光的绿色。当我抬起头时，就像它也在看我。"
]
let TimeArray:[String] = ["14:44","10:04","21:21","12:46","8:13","23:31","10:00","18:59","19:23","6:21","1:09"]




class singleMessageModel {
    var icon:String?
    var myicon = "head"
    var times:String?
    var message:String?
    var youName:String?
    ///0表示自己发，1表示对方发
    var type:Int?
}

class MessageModel {
    var icon:String?
    var myicon = "head"
    var times:String?
    var message:[[String:String]]?
    var youName:String?
    
    
    ///转换后的SingleModel
    var allSingleMessageModel:[singleMessageModel]?
    ///全部转换成SingleModel
    
    
    
}

class MessageModels:NSObject {
    ///对方头像
    var icon:[String] = []
    ///对方的名字
    var youNum:[String] = []
    ///我的头像
    var myicon:String = "head"
    ///所有的信息，字典
    var Message:[[[String:String]]] = []
    ///时间
    var times:[String] = []
    ///所有Cell的Model
    var cells:[MessageModel]?

    
    ///清除数据
    func deleteAllData() {
        self.icon.removeAll()
        self.Message.removeAll()
        self.times.removeAll()
        self.cells?.removeAll()
        self.cells = []
        self.youNum.removeAll()
    }
    //生成不重复头像
    fileprivate var iconCopy = IconArray
    fileprivate var nameCopy = NameArray
    ///随机生成数据
    func initRandomData() {
        self.iconCopy = IconArray
        self.nameCopy = NameArray
        //对话数量
        let num = Int((arc4random() % 11) + 6)
        //添加cell
        for _ in 0..<num {
            let cell = MessageModel()
            self.cells?.append(cell)
        }
        //生成头像，不可以重复,生成名字
        for i in 0..<num {
            let currentNum = Int(arc4random() % UInt32(iconCopy.count))
            let remove = self.iconCopy.remove(at: currentNum)
            icon.append(remove)
            self.cells![i].icon = remove
        }
        for i in 0..<num {
            let currentNum = Int(arc4random() % UInt32(nameCopy.count))
            let remove = self.nameCopy.remove(at: currentNum)
            youNum.append(remove)
            self.cells![i].youName = remove
        }
        //生成时间
        for i in 0..<num {
            let timeNum = Int(arc4random() % UInt32(TimeArray.count))
            self.times.append(TimeArray[timeNum])
            self.cells![i].times = TimeArray[timeNum]
        }
        //随机生成对应信息
        //第几个人的信息
        for i in 0..<num {
            // 每个随机的信息数
            var emptyData:[[String : String]] = []
            let messageNum = Int(arc4random() % 25 + 2)
            for j in 0..<messageNum {
                //随机把信息给予我或他人
                let isMe = arc4random() % 101
               //随机的信息
                let messageRandom = Int(arc4random() % UInt32(MessageArray.count))
                 //1就是我，0他人
                if isMe > 50 {
                    emptyData.append(["me":MessageArray[messageRandom]])
                }
                else {
                    emptyData.append(["other":MessageArray[messageRandom]])
                }
            }
            self.Message.append(emptyData)
            self.cells![i].message = emptyData
        }
        AllMessageData = self.cells!
    }
    
    
    
    
    
    
    
    
    
    
    
}
