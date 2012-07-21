//
//  BookViewController.m
//  MyWebView02
//
//  Created by Coder Dream on 12-7-8.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import "BookViewController.h"

@implementation BookViewController

//@synthesize myCycleScrollView = _myCycleScrollView;
@synthesize myCycleUILabelView = _myCycleUILabelView;
@synthesize sectionName = _sectionName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  /*
   CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
   webFrame.origin.y += 20.0 + 5.0;	// leave from the URL input field and its label
   webFrame.size.height -= 40.0;
   self.myCycleScrollView = [[[CycleScrollView alloc] initWithFrame:webFrame fileName:@"a0" pages:1 scrollDirection:2] autorelease];
   //(id)initWithFrame:(CGRect)frame fileName:(NSString*)name pages:(int)pages scrollDirection:(CycleDirection)direction
   [self.view addSubview:self.myCycleScrollView];
   */
  
  // NSArray *imagesArray=[[NSArray alloc] initWithObjects: [UIImage  imageNamed:@"a01.png"],[UIImage imageNamed:@"a02.png"],[UIImage imageNamed:@"a03.png"],nil];
  
  // CycleScrollView *cycle = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) cycleDirection:0 pictures:imagesArray];
  
  // second method
  NSError *error;
  //stringWithContentsOfURL
  NSString *txtPath = [[[NSBundle mainBundle] bundlePath]
                       stringByAppendingPathComponent: self.sectionName];
  
  
  NSString *textFileContents = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error: &error];
  
  //  NSString *textFileContents = [NSString stringWithContentsOfURL:[NSURL txtPath] encoding:NSUTF8StringEncoding error: &error];
  
  // If there are no results, something went wrong
  if (textFileContents == nil) {
    // an error occurred
    NSLog(@"Error reading text file. %@", [error localizedFailureReason]);
  }
  
  NSArray *lines = [textFileContents componentsSeparatedByString:@"\n"];
  NSLog(@"Number of lines in the file:%d", [lines count] );
  // make many paragraphe
  // NSString *secondParaContent = [lines objectAtIndex:1];
  int oneLineSize = 10; 
  
  // NSArray *stringArray = [[NSArray alloc] arrayWithCapacity:times];
  NSMutableArray *stringArray = [NSMutableArray array];
  //  res = [str1 substringWithRange: NSMakeRange (8, 6)];
  NSString *res;//
  NSInteger lineSize;
  NSInteger idx;
  for (idx = 0; idx < lines.count; idx++){
    NSString *currentLineContent = [lines objectAtIndex:idx];
    lineSize = [currentLineContent length];
    //NSLog(@"%d: size: %d %@", idx, lineSize, currentContent);
    // NSLog(@"%d: size: %d", idx, lineSize);
    
    NSUInteger lineLength = [currentLineContent length];
    //  NSLog(@"line length: %u : %@", lineLength, currentLineContent);
    NSInteger mod = lineLength % oneLineSize;
    NSInteger times = lineLength / oneLineSize;
    int begin = 0;
    
    int idxLine;
    for (idxLine = 0; idxLine < times; idxLine++){
      // NSString *currentContent = [lines objectAtIndex:idx];
      // stringArray[idx] = res;
      begin = idxLine * oneLineSize;
      //NSLog(@"begin:  %d: ", begin);
      res = [currentLineContent substringWithRange: NSMakeRange (begin, oneLineSize)];
      //NSLog(@"size:  %d: count: %@", idxLine, res);
      [stringArray addObject:res];
      // lineSize = [currentContent length];
      //NSLog(@"%d: size: %d %@", idx, lineSize, currentContent);
      // NSLog(@"%d: size: %d", idx, lineSize);
    }     
    
    if (0 != mod) {
      // times += 1;
      res = [currentLineContent substringWithRange: NSMakeRange (idxLine * oneLineSize, lineLength - idxLine * oneLineSize)];
      [stringArray addObject:res];
      //NSLog(@"size:  %d: count: %@", idxLine, res);
    }
  }
  
  NSLog(@"### stringArray count: %d", [stringArray count]);
  
  
  // = [str1 substringWithRange: NSMakeRange (8, 6)];
  /*
   res = [secondLineContent substringWithRange: NSMakeRange (0, 50)];
   NSLog(@"size:  1:    count: %@", res);
   //res = [secondLineContent substringWithRange: NSMakeRange (0, 49)];
   res = [secondLineContent substringWithRange: NSMakeRange (50, 50)];
   NSLog(@"size:  2:    count: %@", res);
   res = [secondLineContent substringWithRange: NSMakeRange (100, 50)];
   //res = [secondLineContent substringWithRange: NSMakeRange (100, 149)];
   NSLog(@"size:  3:    count: %@", res);
   res = [secondLineContent substringWithRange: NSMakeRange (150, 50)];
   //res = [secondLineContent substringWithRange: NSMakeRange (150, 199)];
   NSLog(@"size:  4:    count: %@", res);
   
   
   int begin;
   
   int idxLine;
   for (idxLine = 0; idxLine < times; idxLine++){
   // NSString *currentContent = [lines objectAtIndex:idx];
   // stringArray[idx] = res;
   begin = idxLine * lineSize;
   NSLog(@"begin:  %d: ", begin);
   res = [secondParaContent substringWithRange: NSMakeRange (begin, lineSize)];
   NSLog(@"size:  %d: count: %@", idxLine, res);
   [stringArray addObject:res];
   // lineSize = [currentContent length];
   //NSLog(@"%d: size: %d %@", idx, lineSize, currentContent);
   // NSLog(@"%d: size: %d", idx, lineSize);
   }   
   
   
   if (0 != mod) {
   // times += 1;
   res = [secondParaContent substringWithRange: NSMakeRange (idxLine * lineSize, lineLength - idxLine * lineSize)];
   [stringArray addObject:res];
   NSLog(@"size:  %d: count: %@", idxLine, res);
   }
   */

 // NSArray *contents= [[NSArray alloc] initWithObjects:@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eghit",nil];
  NSArray *contents1= [[NSArray alloc] initWithObjects:@"第二章：死人井",
                      @"后花园的墙角那里有一",
                      @"架紫藤，从夏天到秋天",
                      @"，紫藤花一直沉沉地开",
                      @"着。颂莲从她的窗口看",
                      @"见那些紫色的絮状花朵",
                      @"在秋风中摇曳，一天天",
                      @"地清淡。她注意到紫藤",
                      @"架下有一口井，而且还",
                      @"有石桌和石凳，一个挺",
                      @"闲适的去处却见不到人",
                      @"，通往那里的甬道上长",
                      @"满了杂草。蝴蝶飞过去",
                      @"，蝉也在紫藤枝叶上唱",
                      @"，颂莲想起去年这个时",
                      @"候，她是坐在学校的紫",
                      @"藤架下读书的，一切都",
                      @"恍若惊梦，颂莲慢慢地",
                      @"走过去，她提起裙子，",
                      @"小心不让杂草和昆虫碰",
                      @"蹭，慢慢地撩开几枝藤",
                      @"叶，看见那些石桌石凳",
                      @"上积了一层灰尘。走到",
                      @"井边，井台石壁上长满",
                      @"了青苔，颂莲弯腰朝井",
                      @"中看，井水是蓝黑色的",
                      @"，水面上也浮着陈年的",
                      @"落叶，颂莲看见自己的",
                      @"脸在水中闪烁不定，听",
                      @"见自己的喘息声被吸入",
                      @"井中放大了，沉闷而微",
                      @"弱、有一阵风吹过来，",
                      @"把颂莲的裙子吹得如同",
                      @"飞鸟，颂莲这时感到一",
                      @"种坚硬的凉意，像石头",
                      @"一样慢慢敲她的身体，",
                      @"颂莲开始往回走，往回",
                      @"走的速度很快，回到南",
                      @"厢房的廊下，她吐出一",
                      @"口气，回头又看那个紫",
                      @"藤架，架上倏地落下两",
                      @"三串花，很突然的落下",
                      @"来，颂莲觉得这也很奇",
                      @"怪。",
                      @"卓云在房里坐着，等着",
                      @"颂莲。她乍地发觉颂莲",
                      @"的脸色很难看，卓云起",
                      @"来扶着颂莲的腰，你怎",
                      @"么啦？颂莲说，我怎么",
                      @"啦？我上外面走了走。",
                      @"卓云说，你脸色不好，",
                      @"颂莲笑了笑说身上来了",
                      @"。卓云也笑，我说老爷",
                      @"怎么又上我那儿去了呢",
                      @"。她打开一个纸包，拉",
                      @"出一卷丝绸来，说，苏",
                      @"州的真丝，送你裁件衣",
                      @"服，颂莲推卓云的手，",
                      @"不行，你给我东西，怎",
                      @"么好意思，应该我给你",
                      @"才对。卓云嘘了一声，",
                      @"这是什么道理？我见你",
                      @"特别可心，就想起来这",
                      @"块绸子，要是隔壁那女",
                      @"人，她掏钱我也不给，",
                      @"我就是这脾气。颂莲就",
                      @"接过绸子放在膝上摩掌",
                      @"着，说，三太太是有点",
                      @"怪。不过，她长得真好",
                      @"看。卓云说，好看什么",
                      @"？脸上的粉霜一刮掉半",
                      @"斤。颂莲又笑，转了话",
                      @"题，我刚才在紫藤架那",
                      @"儿呆了会，我挺喜欢那",
                      @"儿的。卓云就叫起来，",
                      @"你去死人井了？别去那",
                      @"儿，那儿晦气。颂莲吃",
                      @"惊道，怎么叫死人井？",
                      @"卓云说，怪不得你进屋",
                      @"脸色不好，那井里死过",
                      @"三个人。颂莲站起身伏",
                      @"在窗口朝紫藤架张望，",
                      @"都是什么人死在井里了",
                      @"？卓云说，都是上代的",
                      @"家眷，都是女的。颂莲",
                      @"还要打听，卓云就说不",
                      @"上来了。卓云只知道这",
                      @"些，她说陈家上下忌讳",
                      @"这些事，大家都守口如",
                      @"瓶。颂莲愣了、会，说",
                      @"，这些事情，不知道就",
                      @"不知道罢。",
                      @"陈家的少爷小姐都住在",
                      @"中院里。颂莲曾经看见",
                      @"忆容和忆云姐妹俩在泥",
                      @"沟边挖蚯蚓，喜眉喜眼",
                      @"天真烂漫的样子，颂莲",
                      @"一眼就能判断她们是卓",
                      @"云的骨血。她站在一边",
                      @"悄悄地看她们，姐妹俩",
                      @"发觉了颂莲，仍然旁若",
                      @"无人，把蚯蚓灌到小竹",
                      @"筒里。颂莲说，你们挖",
                      @"蚯蚓做什么？忆容说，",
                      @"钓鱼呀，忆云却不客气",
                      @"地白了颂莲一眼，不要",
                      @"你管。颂莲有点没趣，",
                      @"走出几步，听见姐妹俩",
                      @"在嘀咕，她也是小老婆",
                      @"，跟妈一样。颂莲一下",
                      @"懵了，她回头愤怒地盯",
                      @"着她们看，忆容嗤嗤地",
                      @"笑着，忆云却丝毫不让",
                      @"地朝她撇嘴，又嘀咕了",
                      @"一句什么。颂莲心想这",
                      @"叫什么事儿，小小年纪",
                      @"就会说难听话。天知道",
                      @"卓云是怎么管这姐妹俩",
                      @"的。",
                      @"颂莲再碰到卓云时，忍",
                      @"不住就把忆云的话告诉",
                      @"她。卓云说，那孩子就",
                      @"是嘴上没拦的，看我回",
                      @"去拧她的嘴。卓云赔礼",
                      @"后又说，其实我那两个",
                      @"孩子还算省事的，你没",
                      @"见隔壁小少爷，跟狗一",
                      @"样的，见人就咬，吐唾",
                      @"沫。你有没有挨他咬过",
                      @"？颂莲摇摇头，她想起",
                      @"隔壁的小男孩飞澜，站",
                      @"在门廊下，一边啃面包",
                      @"，一边朝她张望，头发",
                      @"梳得油光光的，脚上穿",
                      @"着小皮鞋，颂莲有时候",
                      @"从飞澜脸上能见到类似",
                      @"陈佐千的表情，她从心",
                      @"理上能接受飞澜，也许",
                      @"因为她内心希望给陈佐",
                      @"千再生一个儿子。男孩",
                      @"比女孩好，颂莲想，管",
                      @"他咬不咬人呢。",
                      @"只有毓如的一双儿女，",
                      @"颂莲很久都没见到。显",
                      @"而易见的是他们在陈府",
                      @"的地位。颂莲经常听到",
                      @"关于对飞浦和忆惠的谈",
                      @"论。飞浦一直在外面收",
                      @"账，还做房地产生意，",
                      @"而忆惠在北平的女子大",
                      @"学读书。颂莲不经意地",
                      @"向雁儿打听飞浦，雁儿",
                      @"说，我们大少爷是有本",
                      @"事的人。颂莲问，怎么",
                      @"个有本事法？雁儿说，",
                      @"反正有本事，陈家现在",
                      @"都靠他。颂莲又问雁儿",
                      @"，大小姐怎么样？雁儿",
                      @"说，我们大小姐又漂亮",
                      @"又文静，以后要嫁贵人",
                      @"的。颂莲心里暗笑，雁",
                      @"儿褒此贬彼的话音让她",
                      @"很厌恶，她就把气发到",
                      @"裙据下那只波斯猫身上",
                      @"，颂莲抬脚把猫踢开，",
                      @"骂道，贱货，跑这儿舔",
                      @"什么骚？",
                      @"颂莲对雁儿越来越厌恶",
                      @"，至关重要的一点是她",
                      @"没事就往梅珊屋里跑，",
                      @"而且雁儿每次接过颂莲",
                      @"的内衣内裤去洗时，总",
                      @"是一脸不高兴的样子。",
                      @"颂莲有时候就训她，你",
                      @"挂着脸给谁看，你要不",
                      @"愿跟我就回下房去，去",
                      @"隔壁也行。雁儿申辩说",
                      @"，没有呀，我怎么敢挂",
                      @"脸，天生就没有脸。颂",
                      @"莲抓过一把梳子朝她砸",
                      @"过去，雁儿就不再吱声",
                      @"了。颂莲猜测雁儿在外",
                      @"面没少说她的坏话。但",
                      @"她也不能对她太狠，因",
                      @"为她曾经看见陈佐千有",
                      @"一次进门来顺势在雁儿",
                      @"的乳房上摸了一把，虽",
                      @"然是瞬间的很自然的事",
                      @"，颂莲也不得不节制一",
                      @"点，要不然雁儿不会那",
                      @"么张狂。颂莲想，连个",
                      @"小丫环也知道靠那一把",
                      @"壮自己的胆、女人就是",
                      @"这种东西。",
                      @"到了重阳节的前一天，",
                      @"大少爷飞浦回来了。",
                      @"颂莲正在中院里欣赏菊",
                      @"花，看见毓如和管家都",
                      @"围拢着几个男人，其中",
                      @"一个穿白西服的很年轻",
                      @"，远看背影很魁梧的，",
                      @"颂莲猜他就是飞浦。她",
                      @"看着下人走马灯似地把",
                      @"一车行李包裹运到后院",
                      @"去，渐渐地人都进了屋",
                      @"，颂莲也不好意思进去",
                      @"，她摘了枝菊花，慢慢",
                      @"地踱向后花园，路上看",
                      @"见卓云和梅珊，带着孩",
                      @"子往这边走，卓云拉住",
                      @"颂莲说，大少爷回家了",
                      @"，",
                      @"你不去见个面？颂莲说",
                      @"，我去见他？应该他来",
                      @"见我吧。卓云说，说的",
                      @"也是，应该他先来见你",
                      @"。一边的梅珊则不耐烦",
                      @"地拍拍飞澜的头颈，快",
                      @"走快走。",
                      @"颂莲真正见到飞浦是在",
                      @"饭桌上。那天陈佐千让",
                      @"厨子开了宴席给飞浦接",
                      @"风，桌上摆满了精致丰",
                      @"盛的菜肴，颂莲唆巡着",
                      @"桌子，不由得想起初进",
                      @"陈府那天，桌上的气派",
                      @"远不如飞浦的接风宴，",
                      @"心里有点犯酸，但是很",
                      @"快她的注意力就转移到",
                      @"飞浦身上了。飞浦坐在",
                      @"毓如身边，毓如对他说",
                      @"了句什么，然后飞浦就",
                      @"欠起身子朝颂莲微笑着",
                      @"点了点头。颂莲也颔首",
                      @"微笑。她对飞浦的第一",
                      @"个感觉是出乎意料地英",
                      @"俊年轻，第二个感觉是",
                      @"他很有心计。颂莲往往",
                      @"是喜欢见面识人的。",
                      @"第二天就是重阳节了，",
                      @"花匠把花园里的菊花盆",
                      @"全搬到一起去，五颜六",
                      @"色地搭成福、禄、寿、",
                      @"禧四个字，颂莲早早地",
                      @"起来，一个人绕着那些",
                      @"菊花边走边看，早晨有",
                      @"凉风，颂莲只穿了一件",
                      @"毛背心，她就抱着双肩",
                      @"边走边看。远远地她看",
                      @"见飞浦从中院过来，朝",
                      @"这里走。颂莲正犹豫着",
                      @"是否先跟他打招呼，飞",
                      @"浦就喊起来，颂莲你早",
                      @"。颇莲对他直呼其名有",
                      @"点吃惊，她点点头，说",
                      @"，按辈份你不该喊我名",
                      @"字。飞浦站在花圃的另",
                      @"一边，笑着系上衬衫的",
                      @"领扣，说，应该叫你四",
                      @"太太，但你肯定比我小",
                      @"几岁呢，你多大？颂莲",
                      @"显出不高兴的样子侧过",
                      @"脸去看花。飞浦说，你",
                      @"也喜欢菊花，我原以为",
                      @"大清早的可以先抢风水",
                      @"，没想你比我还早，颂",
                      @"莲说，我从小就喜欢菊",
                      @"花，可不是今天才喜欢",
                      @"的。飞浦说，最喜欢哪",
                      @"种，颂莲说，都喜欢，",
                      @"就讨厌蟹爪。飞浦说，",
                      @"那是为什么。颂莲说，",
                      @"蟹爪开得大张狂。飞浦",
                      @"又笑起来说，有意思了",
                      @"，我偏偏最喜欢蟹爪，",
                      @"颂莲睃了飞浦一眼，我",
                      @"猜到你会喜欢它。飞浦",
                      @"又说，那又为什么？颂",
                      @"莲朝前走了几步，说，",
                      @"花非花，人非人，花就",
                      @"是人，人就是花，这个",
                      @"道理你不明白？颂莲猛",
                      @"地抬起头，她察觉出飞",
                      @"浦的眼神里有一种异彩",
                      @"水草般地掠过，她看见",
                      @"了，她能够捕捉它。飞",
                      @"浦叉腰站在菊花那一侧",
                      @"，突然说，我把蟹爪换",
                      @"掉吧。颂莲没有说话。",
                      @"她看着飞浦把蟹爪换掉",
                      @"，端上几盆墨菊摆上。",
                      @"过了一会儿，颂莲又说",
                      @"，花都是好的，摆的字",
                      @"不好、大俗气。飞浦拍",
                      @"拍手上的泥，朝颂莲挤",
                      @"挤眼睛，那就没办法了",
                      @"，福禄寿禧是老爷让摆",
                      @"的，每年都这样，老祖",
                      @"宗传下来的规矩。",
                      @"颂莲后来想起重阳赏菊",
                      @"的情景，心情就愉快。",
                      @"好像从那天起，她与飞",
                      @"浦之间有了某种默契，",
                      @"颂莲想着飞浦如何把蟹",
                      @"爪搬走，有时会笑出声",
                      @"来，只有颂莲自己知道",
                      @"，她并不是特别讨厌那",
                      @"种叫蟹爪的菊花。",
                      @"你最喜欢谁？颂莲经常",
                      @"在枕边这样问陈佐千，",
                      @"我们四个人，你最喜欢",
                      @"谁？陈佐千说那当然是",
                      @"你了。毓如呢？她早就",
                      @"是只老母鸡了。卓云呢",
                      @"？卓云还凑和着但她有",
                      @"点松松垮",
                      @"垮的了。那么梅珊呢？",
                      @"颂莲总是克制不住对梅",
                      @"珊的好奇心，梅珊是哪",
                      @"里人？陈佐千说，她是",
                      @"哪里人我也不知道，连",
                      @"她自己也不知道。颂莲",
                      @"说那梅珊是孤儿出身，",
                      @"陈佐千说，她是戏子，",
                      @"京剧草台班里唱旦角的",
                      @"。我是票友，有时候去",
                      @"后台看她，请她吃饭，",
                      @"一来二去的她就跟我了",
                      @"。颂莲拍拍陈佐千的脸",
                      @"说，是女人都想跟你，",
                      @"陈佐千说，你这话对了",
                      @"一半，应该说是女人都",
                      @"想跟有钱人。颂莲笑起",
                      @"来，你这话也才对了一",
                      @"半，应该说有钱人有了",
                      @"钱还要女人，要也要不",
                      @"够。",
                      @"颂莲从来没有听见梅珊",
                      @"唱过京戏，这天早晨窗",
                      @"外飘过来几声悠长清亮",
                      @"的唱腔，把颂莲从梦中",
                      @"惊醒，她推推身边的陈",
                      @"佐千问是不是梅珊在唱",
                      @"？陈佐千迷迷糊糊他说",
                      @"，她高兴了就唱，不高",
                      @"兴了就笑，狗娘养的，",
                      @"颂莲推开窗子，看见花",
                      @"园里夜来降了雪白的秋",
                      @"霜，在紫藤架下，一个",
                      @"穿黑衣黑裙的女人且舞",
                      @"且唱着。果然就是梅珊",
                      @"。",
                      @"颂莲披衣出来，站在门",
                      @"廊上远远地看着那里的",
                      @"梅珊。梅珊已沉浸其中",
                      @"，颂莲觉得她唱得凄凉",
                      @"婉转，听得心也浮了起",
                      @"来。这样过了好久，梅",
                      @"珊戛然而止，她似乎看",
                      @"见了颂莲的眼睛里充满",
                      @"了泪影。梅珊把长长的",
                      @"水袖搭在肩上往回走，",
                      @"在早晨的天光里，梅珊",
                      @"的脸上、衣服上跳跃着",
                      @"一些水晶色的光点，她",
                      @"的缩成回答的头发被霜",
                      @"露打湿，这样走着她整",
                      @"个显得湿润而优伤，仿",
                      @"佛风中之草。",
                      @"你哭了？你活得不是狠",
                      @"高兴吗，为什么哭？梅",
                      @"珊在颂莲面前站住，淡",
                      @"淡他说。颂莲掏出手绢",
                      @"擦了擦眼角，他说也不",
                      @"知是怎么了，你唱的戏",
                      @"叫什么？叫《女吊》。",
                      @"梅珊说你喜欢听吗？我",
                      @"对京戏一窍不通，主要",
                      @"是你唱得实在动情，听",
                      @"得我也伤心起来，颂莲",
                      @"说着她看见梅珊的脸上",
                      @"第一次露出和善的神情",
                      @"，梅珊低下头看看自己",
                      @"的戏装，她说，本来就",
                      @"是做戏嘛，伤心可不值",
                      @"得。做戏做得好能骗别",
                      @"人，做得不好只能骗骗",
                      @"自己。",
                      @"陈佐千在颂蓬屋里咳嗽",
                      @"起来，颂蓬有些尴尬地",
                      @"看看梅珊。梅珊说，你",
                      @"不去伺侯他穿衣服？颂",
                      @"莲摇摇头说他自己穿，",
                      @"他又不是小孩子。梅珊",
                      @"便有点悻悻的，她笑了",
                      @"笑说他怎么要我给他穿",
                      @"衣穿鞋，看来人是有贵",
                      @"赐之分，这时候陈佐千",
                      @"又在屋里喊起来，梅珊",
                      @"，进屋来给我唱一段！",
                      @"梅珊的细柳眉立刻挑起",
                      @"来，她冷笑一声，跑到",
                      @"窗前冲里面说，老娘不",
                      @"愿意！",
                      @"颂莲见识了梅珊的脾气",
                      @"。当她拐弯抹角他说起",
                      @"这个话题时，陈佐千说",
                      @"，都怪我前些年把她娇",
                      @"宠坏了。她不顺心起来",
                      @"敢骂我家租宗八代，陈",
                      @"佐千说这狗娘养的小婊",
                      @"子，我迟",
                      @"早得狠狠收拾她一回。",
                      @"颂莲说，你也别太狠心",
                      @"了，她其实挺可怜的，",
                      @"没亲没故的，怕你不疼",
                      @"她，脾气就坏了。",
                      @"以后颂莲和梅珊有了些",
                      @"不冷不热的交往，梅珊",
                      @"迷麻将，经常招呼人去",
                      @"她那里搓麻将，从晚饭",
                      @"过后一直搓到深更半夜",
                      @"。颂莲隔着墙能听见隔",
                      @"壁洗牌的哗啦哗啦的声",
                      @"音，吵得她睡不好觉。",
                      @"她跟陈佐千发牢骚，陈",
                      @"佐千说，你就忍一忍吧",
                      @"，她搓上麻将还算正常",
                      @"一点，反正她把钱输光",
                      @"了我不会给她的，让她",
                      @"去搓，让她去作死。但",
                      @"是有一回梅珊差丫环来",
                      @"叫颂莲上牌桌了，颂莲",
                      @"一句话把丫环挡了回去",
                      @"，她说，我去搓麻将？",
                      @"亏你们想得出来。丫环",
                      @"回去后梅珊自己来了，",
                      @"她说，三缺一，赏个脸",
                      @"吧。颂莲说我不会呀，",
                      @"不是找输吗？梅珊来拽",
                      @"她的胳膊，走吧，输了",
                      @"不收你线，要不赢了归",
                      @"你，输了我付。颂莲说",
                      @"，那倒不至于，主要是",
                      @"我不喜欢。她说着就看",
                      @"见梅珊的脸挂下来了，",
                      @"梅珊哼了一声说，你这",
                      @"里有什么呀？好像守着",
                      @"个大金库不肯挪一步，",
                      @"不过就是个干瘪老头罢",
                      @"了；颂莲被呛得恶火攻",
                      @"心，刚想发作，难听话",
                      @"溜到嘴边又咽回去了，",
                      @"她咬着嘴唇考虑了几秒",
                      @"钟说。好吧，“我跟你",
                      @"去。",
                      @"另外两个人已经坐在桌",
                      @"前等候了，一个是管家",
                      @"陈佐文，另一个不认识",
                      @"，梅珊介绍说是医生。",
                      @"那人戴着金丝边眼镜，",
                      @"皮肤黑黑的，嘴唇却像",
                      @"女性一样红润而柔情，",
                      @"颂莲以前见他出入过梅",
                      @"珊的屋子，她不知怎么",
                      @"就不相信他是医生。",
                      @"颂莲坐在牌桌上心不在",
                      @"焉，她是真的不太会打",
                      @"，糊里糊涂就听见他们",
                      @"喊和了，自摸了。她只",
                      @"是掏钱，慢慢地她就心",
                      @"疼起来，她说，我头疼",
                      @"，想歇一歇了。梅珊说",
                      @"，上桌就得打八圈，这",
                      @"是规矩。你恐怕是输得",
                      @"心疼吧，陈佐文在一边",
                      @"说，没关系的，破点小",
                      @"财消灾灭祸。梅珊又说",
                      @"，你今天就算给卓云做",
                      @"好事吧，这一阵她闷死",
                      @"了，把老头儿借她一夜",
                      @"，你输的钱让她掏给你",
                      @"。桌上的两个男人都笑",
                      @"起来。颂莲也笑，梅珊",
                      @"你可真能逗乐，心里却",
                      @"像吞了只苍蝇。",
                      @"颂莲冷眼观察着梅珊和",
                      @"医生间的眉目传情，她",
                      @"想什么事情都一下就发",
                      @"现了他们的四条腿的形",
                      @"状，藏在桌下的那四条",
                      @"腿原来紧缠在一起，分",
                      @"开时很快很自然，但颂",
                      @"莲是确确实实看见了。",
                      @"颂莲不动声色。她再也",
                      @"不去看梅珊和医生的脸",
                      @"了。颂莲这时的心情很",
                      @"复杂，有点惶惑，有点",
                      @"紧张，还有一点幸灾乐",
                      @"祸，她心里说梅珊你活",
                      @"得也大自在了也太张狂",
                      @"了。",
                       nil];
  
  NSArray *contents= stringArray;
  self.myCycleUILabelView =  [[[CycleUILabelView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) contentArray:contents scrollDirection:LandscapeDirection] autorelease];
  [self.view addSubview:self.myCycleUILabelView];
  
  UIView *bottomView = [[ UIView alloc ]  initWithFrame :CGRectMake (0, 480-70, 360, 70 )];
  bottomView.backgroundColor=[ UIColor grayColor ];
  bottomView.alpha= 0.8 ;
  
  //UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
  UIButton *backButton=[ UIButton buttonWithType : UIButtonTypeRoundedRect ];
  [backButton setTitle: @"回目录" forState: UIControlStateNormal ];
  backButton.frame= CGRectMake (10 , 15, 100, 40 );
  
  [bottomView addSubview:backButton];
  // TODO
  //添加点击按钮所执行的程式
  
  [backButton addTarget: self action :@selector (buttonClicked)forControlEvents: UIControlEventTouchUpInside ];
  [self. view addSubview :bottomView];
}

-(void) buttonClicked {
  
  NSLog( @"get detail …, window.views: %@",self. view .window .subviews);
  //[self.view removeFromSuperview];
  [self dismissModalViewControllerAnimated :YES];
}


-(void)pageViewClicked:(NSInteger)pageIndex {
  NSLog(@"pageViewClicked");
}


- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
