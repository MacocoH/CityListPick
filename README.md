# CityListPick    
![](https://github.com/MacocoH/CityListPick/blob/master/Screen.gif)   
城市选择列表，其中包括定位城市和热门城市以及城市列表    
定位城市和热门城市根据实际情况传入    
城市列表读取的plist文件根据实际需要更改   
    
## 调用方法      
    CityPickVC *city = [[CityPickVC alloc]init];    
    city.locationCity = @"北京";    
    city.hotCityArray = @[@"北京市",@“天津市”,@"杭州市"];
    city.selectCityName = ^(NSString *cityName) {    
    //cityName为选择的城市;       
    };     
    [self.navigationController:city animated:YES];   
## 属性列表
    /**
     *  定位城市名称
     */
    @property (nonatomic,copy) NSString *locationCity;
    /**
     *  热门城市列表
     */
    @property (nonatomic,copy) NSArray<NSString *> *hotCityArray;
    /**
     *  选择的城市回调
     */
    @property (nonatomic,copy) void (^selectCityName)(NSString *cityName);
