#define kAppDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define kRESTBaseUrl @"http://www.haodou.com/api.php?appid=1&appkey=1234567894123&format=json&method=%@"

#define kDataBase  @"citys.db"

#define kCitySql @"select id,cn from citys where cn like ? or py like ? or sp like ?"

#define kShopcateSql @"select ShopCateId,CateName from ShopCate"

#define kGpsCitySql @"select id,cn from citys where cn = ?"

//AreaId:编号  CityId:城市Id  AreaName:地区名 PareaId：商圈：上一级区域编号,一般在商区这一层时会有区的编号,比如:五一广场->芙蓉区->长沙市 
//Lng:经度 Lat:纬度 Status: 状态

#define kAreaSql @"select AreaId,AreaName,PAreaId,Lng,Lat from Area where CityId = ? and PAreaId =?"

#define kPareaSql @"select AreaId,AreaName,PAreaId,Lng,Lat from Area where (CityId = ? and PAreaId =?) or AreaId = ? order by AreaId"

#define kSinaOAuthConsumerKey			@"1676587957"		//REPLACE ME　　666411903
#define kSinaOAuthConsumerSecret		@"58724e0850e524249fbe4d191f21c451"		//REPLACE ME

#define kQqOAuthConsumerKey				@"080c22ccdee943c0a527b14278aa6b69"		//REPLACE ME
#define kQqOAuthConsumerSecret			@"77e6b14048a602ff884683b4557a787a"		//REPLACE ME

#define kUmengAppKey @"4e33bf16431fe3244c0001f3"

#define kGryColor RGBCOLOR(153, 153,153)
