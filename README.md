# CityListPick
# 选择城市列表    
仿照各个应用的城市选择列表    
# 调用方法      
CityPickVC *city = [[CityPickVC alloc]init];    
city.locationCity = @"北京";    
city.hotCityArray = @[@"北京市",@“天津市”,@"杭州市"];
city.selectCityName = ^(NSString *cityName) {    
//cityName为选择的城市;       
};     
[self.navigationController:city animated:YES];   
