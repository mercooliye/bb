//
//  MasterViewController.m
//  beautybox
//
//  Created by Evgeniy Merkulov on 25.07.2018.
//  Copyright © 2018 Evgeniy Merkulov. All rights reserved.
//

#import "MasterViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Section.h"
#import "ServiceTableViewCell.h"
#import "ReviewTableViewCell.h"
#import "UIImage+Rotate.h"
#import "UnderMap.h"
#import "WorkTimeViewController.h"
#import "DetailInfoViewController.h"
#import "ReviewsViewController.h"
#import "UIColor+Main.h"
#import "NSString+Ending.h"
#import "ImageZoomViewer.h"
#import "AppDelegate.h"

@interface MasterViewController ()

@end

@implementation MasterViewController
@synthesize tab;
@synthesize tableView;
@synthesize master;
@synthesize mapView;
@synthesize ratingControl;
@synthesize countReviews;
@synthesize adressLabel;
@synthesize favButton;
@synthesize customerIsCollapsed;
@synthesize siteIsCollapsed;
@synthesize catMaster;
@synthesize selecteds;

-(void)viewWillAppear:(BOOL)animated
{
    [tab setPosition:0];
    [self tapSelection:0];
    [self setTitle:[master objectForKey:@"name"]];
    [self stopSpin];
    [Api masterWithId:[master objectForKey:@"userID"] lock:^(NSObject *result) {
        
        NSDictionary *res=(NSDictionary*)result;
        if([res objectForKey:@"data"])
            master=[res objectForKey:@"data"];
        self.services=[master objectForKey:@"services"];
        self.reviews=[master objectForKey:@"reviewText"];
        [tableView reloadData];
        [self stopSpin];
        
        countReviews.text=@"";
        ratingControl.rating=[[master objectForKey:@"ratingReviews"] integerValue]?:0;
        if([master objectForKey:@"countReviews"])
        {
            countReviews.text=[NSString stringWithFormat:@"(%@)",[master objectForKey:@"countReviews"]];
        }
        
        //if([master objectForKey:@"address"])
        //   adressLabel.text=[NSString stringWithFormat:@"%@",[master objectForKey:@"name"]];
        
        
        if(ratingControl.rating==0)
        {
            ratingControl.hidden=YES;
            countReviews.hidden=YES;
            [adressLabel setY:320];

        }
        else
        {
            countReviews.hidden=NO;
            ratingControl.hidden=NO;
        }
        
        if([[master objectForKey:@"favorite"] integerValue]==1)
        {
            [favButton setImage:[UIImage imageNamed:@"love_sel"] forState:UIControlStateNormal];
            favButton.tag=1;
        }
        else
        {
            [favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
            favButton.tag=0;
            
        }
        
    }];
    self.tabBarController.tabBar.hidden=YES;
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                    target:self
                                    action:@selector(shareAction)];
    //[shareButton setImage:[UIImage imageNamed:@"share"]];
    self.navigationItem.rightBarButtonItem = shareButton;
}
-(void)shareAction
{
    NSArray *itemsToShare = @[[master objectForKey:@"name"]];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePostToWeibo,UIActivityTypePostToTwitter,UIActivityTypePostToFacebook,UIActivityTypeMail,UIActivityTypeMessage,UIActivityTypeAssignToContact,UIActivityTypePostToTencentWeibo];
    [self presentViewController:activityVC animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    selecteds=[NSMutableDictionary new];
    
    self.collapseSection=0;
    tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.width, self.height-65)];
    UINib* nib = [UINib nibWithNibName:@"Section" bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"Section"];
    [tableView registerNib:[UINib nibWithNibName:@"ServiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"ServiceTableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"ReviewTableViewCell" bundle:nil] forCellReuseIdentifier:@"ReviewTableViewCell"];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    tableView.tableHeaderView=[self header];
    [self.view addSubview:tableView];
    tableView.delegate=self;
    tableView.dataSource=self;
    
    tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];
    
    
    
    tab=[[TabBar alloc] initWithFrame:CGRectMake(0,  tableView.tableHeaderView.frame.size.height, self.view.frame.size.width, 60) titles:@[@"Услуги",@"Карта",@"Отзывы"]] ;
    tab.delegate=self;
    tab.selectIndex=0;
    [tab setSelectPosition:0];
    [self.view addSubview:tab];
    
    
}

-(UIView*)header
{
    float h=300;
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, h)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:view.frame];
    [view addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.delegate=self;
    scrollView.pagingEnabled=YES;
    
    NSArray *files=[master objectForKey:@"files"];
    for(int i=0;i<files.count;i++)
    {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(i*self.width, 0, self.width, 300)];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openPhoto:)];
        imageView.tag=i;
        
        imageView.userInteractionEnabled=YES;
        [imageView addGestureRecognizer:tap];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setClipsToBounds:YES];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[files objectAtIndex:i]]];
        [scrollView addSubview:imageView];
        [scrollView setContentSize:CGSizeMake((i+1)*self.width, 0)];
    }
 
    //[scrollView setBouncesZoom:YES];
    self.pageController=[[UIPageControl alloc] initWithFrame:CGRectMake(0, 250, self.width, 50)];
    [view addSubview:self.pageController];
    self.pageController.numberOfPages=files.count;
    
    
    ratingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(20, 310) emptyColor:[UIColor grayColor] solidColor:[UIColor yelow] andMaxRating:5 ];
    [ratingControl setUserInteractionEnabled:NO];
    [ratingControl setTintColor:[UIColor whiteColor]];
    [view addSubview:ratingControl];
 
    countReviews=[[UILabel alloc] initWithFrame:CGRectMake(ratingControl.frame.size.width+30, ratingControl.frame.origin.y+3, 100, ratingControl.frame.size.height)];
    [countReviews setFont:[UIFont fontWithName:@"SFUIText-Regular" size:13]];
    [view addSubview:countReviews];
  
    
    adressLabel=[[ARLabel alloc] initWithFrame:CGRectMake(20, 335, self.width-100, 60)];
    [adressLabel setNumberOfLines:2];
    [adressLabel setFont:[UIFont fontWithName:@"SFUIText-Regular" size:18]];
    [adressLabel setText:[master objectForKey:@"name"]];
    [adressLabel fitHeight];
    
    [view addSubview:adressLabel];

    [view setFrame:CGRectMake(0, 0, self.width, adressLabel.y+adressLabel.height+70)];
    
    if(!TOKEN)
    {
        
    }
    else
    {
        
    favButton=[[UIButton alloc] initWithFrame:CGRectMake(self.width-50, adressLabel.y, 25, 25)];
    [favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
    [favButton setCenter:CGPointMake(favButton.center.x, adressLabel.center.y)];
    
        [view addSubview:favButton];
        [favButton addTarget:nil action:@selector(fav:) forControlEvents:UIControlEventTouchDown];

    if([[master objectForKey:@"favorite"] integerValue]==1)
    {
        [favButton setImage:[UIImage imageNamed:@"love_sel"] forState:UIControlStateNormal];
        favButton.tag=1;
    }
    else
    {
        [favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        favButton.tag=0;

    }
    }

    
    return view;
}


-(void)fav:(UIButton*)sender
{
    if(favButton.tag==0)
    {
        [favButton setImage:[UIImage imageNamed:@"love_sel"] forState:UIControlStateNormal];
        favButton.tag=1;
    [Api masterAddFav:[master objectForKey:@"userID"] block:^(NSObject *result) {
        
    }];
    }
    else
    {
        favButton.tag=0;
        [favButton setImage:[UIImage imageNamed:@"fav"] forState:UIControlStateNormal];
        [Api masterDeleteFav:[master objectForKey:@"userID"] block:^(NSObject *result) {
        }];
    }

}



#pragma mark - UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    ServiceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceTableViewCell"];
    NSArray *subservices=[[self.services objectAtIndex:indexPath.section]  objectForKey:@"service"];
    NSDictionary *service=[subservices objectAtIndex:indexPath.row];
    cell.nameLabel.text=[service objectForKey:@"name"];
    cell.priceLabel.text=[NSString stringWithFormat:@"%@ ₽",[service objectForKey:@"price"]];
    cell.infoButton.tag=indexPath.row;
    [cell.infoButton addTarget:nil action:@selector(infoService:) forControlEvents:UIControlEventTouchDown];
        cell.periodLabel.text=[NSString stringWithFormat:@"%@ мин.",[service objectForKey:@"time"]];
    
    [cell.plusButton addTarget:nil action:@selector(addService:) forControlEvents:UIControlEventTouchDown];
    cell.plusButton.tag=indexPath.row;
    if([selecteds objectForKey:[NSString stringWithFormat:@"%ld_%ld", (long)indexPath.row,self.collapseSection]])
        [cell.plusButton setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    else
        [cell.plusButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];


    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)infoService:(UIButton*)sender
{
    NSDictionary *service= [[[self.services objectAtIndex:self.collapseSection] objectForKey:@"service"] objectAtIndex:sender.tag];
    [self detailInfo:[service objectForKey:@"info"]];
}

-(void)addService:(UIButton*)sender
{
    if(catMaster==nil)
    {
        catMaster = [[[NSBundle mainBundle] loadNibNamed:@"CatMaster" owner:self options:nil] objectAtIndex:0];
        [self.view addSubview:catMaster];
    }
    float price=[[[[[self.services objectAtIndex:self.collapseSection] objectForKey:@"service"] objectAtIndex:sender.tag] objectForKey:@"price"] floatValue];

    if(![selecteds objectForKey:[NSString stringWithFormat:@"%ld_%ld", (long)sender.tag,self.collapseSection]])
    {
        
    [sender setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    [selecteds setObject:@"1" forKey:[NSString stringWithFormat:@"%ld_%ld", (long)sender.tag,self.collapseSection]];
        
     catMaster.frame=CGRectMake(0, self.height-55, self.width, 55);
    catMaster.summ=price+catMaster.summ;
    catMaster.count++;
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [selecteds removeObjectForKey:[NSString stringWithFormat:@"%ld_%ld", (long)sender.tag,self.collapseSection]];
        catMaster.summ=catMaster.summ-price;
        catMaster.count--;
        if(catMaster.count==0)
        {
            self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];

            [catMaster removeFromSuperview];
            catMaster=nil;
        }
    }
    
    if(catMaster)
    {
        self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];

        catMaster.numberLabel.text=[NSString stringWithFormat:@"%d", catMaster.count];
        catMaster.sumLabel.text=[NSString stringWithFormat:@"%.0f ₽", catMaster.summ];

    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tab.selectIndex==0
       ||tab.selectIndex==2)
    return 60;
    //if(tab.selectIndex==2)
    //    return UITableViewAutomaticDimension;//высота для комментариев
    return 0;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tab.selectIndex==0
       ||tab.selectIndex==2)
    {
    Section* header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Section"];
    
    [header setBackgroundColor:[UIColor whiteColor]];
    
    header.tag = section;
    
     UIButton *btnCollapse = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCollapse setFrame:CGRectMake(0, 0, self.width, header.frame.size.height)];
    [btnCollapse setBackgroundColor:[UIColor clearColor]];
    [btnCollapse addTarget:self action:@selector(touchedSection:) forControlEvents:UIControlEventTouchUpInside];
    btnCollapse.tag = section;

    [header addSubview:btnCollapse];
    int count=[(NSArray*)[[self.services objectAtIndex:section] objectForKey:@"service"] count];
    NSString *text=@"услуг";
    if(count<5)
        text=@"услуги";
    
        NSString*word=[NSString ending:count words:@[@"услуга",@"услуги",@"услуг"]];
        
    if(self.collapseSection==section)
        [header.iconRight setImage:[UIImage imageNamed:@"up"]];

    else
        [header.iconRight setImage:[UIImage imageNamed:@"down"]];

    header.nameLabel.text=[[self.services objectAtIndex:section] objectForKey:@"name"];
    header.serviceCountLabel.text=[NSString stringWithFormat:@"%lu %@",[(NSArray*)[[self.services objectAtIndex:section] objectForKey:@"service"] count], word];
    
    return header;
    }
    return nil;
}

- (IBAction)touchedSection:(id)sender
{
    UIButton *btnSection = (UIButton *)sender;
    if(self.collapseSection==btnSection.tag)
    {
        self.collapseSection=-1;
     }
    else
    {
        self.collapseSection=btnSection.tag;
       
    }
        NSLog(@"Touched Customers header");
        if(!customerIsCollapsed)
            customerIsCollapsed = YES;
        else
            customerIsCollapsed = NO;
    [tableView reloadData];
    if(self.collapseSection==btnSection.tag)
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:btnSection.tag] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if(tab.selectIndex==0
       ||tab.selectIndex==2)
    {
    if(self.collapseSection==section)
       return [(NSArray*)[[self.services objectAtIndex:section] objectForKey:@"service"] count];
    }
    if(tab.selectIndex==2)
    {
        return _reviews.count;
    }
        
    
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    switch (tab.selectIndex) {
        case 0:
            return self.services.count;
            break;
        case 1:
            return 0;
            break;
        case 2:
            
            return self.services.count;

            break;
        default:
            return 0;
            break;
            
            return 0;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tab.selectIndex==2)
        return 0;
    return 60;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     if(scrollView==tableView)
    {
    float newHeight = tableView.tableHeaderView.frame.size.height+10 - scrollView.contentOffset.y;
    
    if (newHeight < 75) {
        newHeight = 75;
    }
    else
    {
        //self.heighImage.constant=353*(1-(314 - newHeight) / 314 * 1.5);
        
    }
    tab.frame=CGRectMake(tab.frame.origin.x, newHeight-10, self.view.frame.size.width, 50);
  
    if (newHeight < 100) {
        
    }
    else {
    
    }
    }
    else
    {
            CGFloat pageWidth = scrollView.frame.size.width;
            float fractionalPage = scrollView.contentOffset.x / pageWidth;
            NSInteger page = lround(fractionalPage);
            self.pageController.currentPage = page;
        
    }
    
}


- (void)tapTabBar:(UIButton*)button
{
    [self tapSelection:button.tag ];
}

-(void)tapSelection:(NSInteger)index
{
    if(index==2)
    {
        [self setTitle:@""];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ReviewsViewController *vc = (ReviewsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ReviewsViewController"];
        vc.reviews=_reviews;
        vc.master=master;
        vc.rating=[master objectForKey:@"ratingReviews"];
        [self.navigationController pushViewController:vc animated:YES];
        
        [mapView removeFromSuperview];
        if(catMaster)
            //self.tableView.tableFooterView.frame=CGRectMake(0, 0, self.width, 0);
            
            [tab setSelectIndex:0];
        
        
    }
    if(index!=1)
    {
        [mapView removeFromSuperview];
        if(!catMaster||!catMaster.superview)
            self.tableView.tableFooterView.frame=CGRectMake(0, 0, self.width, 0);
    }
    else
    {
        if(mapView.superview==nil)
            [self initMapAndText];
    }
    
    [tableView reloadData];
}

-(void)initMapAndText
{
        if(catMaster==nil||catMaster.superview==nil)
            self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.height-170)];
            else
                self.tableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.height-120)];
    [self.tableView.tableFooterView setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableFooterView.clipsToBounds=YES;
    
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, 0, self.width, self.height-400) camera:[GMSCameraPosition cameraWithLatitude:1                                                                                                                            longitude:1                                                                                                                                 zoom:14]];
    mapView.myLocationEnabled = YES;
    mapView.delegate=self;
    mapView.mapType=kGMSTypeNormal;
    mapView.settings.myLocationButton = YES;
    
    NSString *coords=[master objectForKey:@"coords"];
    NSArray *split=[coords componentsSeparatedByString:@","];
    
    GMSMarker *marker=[[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([split[0] doubleValue], [split[1] doubleValue]);
    marker.title=[master objectForKey:@"address"];
    [marker setAppearAnimation:kGMSMarkerAnimationPop];
    [marker setIcon:[UIImage imageNamed:@"marker"]];
    marker.infoWindowAnchor=CGPointMake(0.15, 0.15);
    marker.map=mapView;
    mapView.myLocationEnabled=YES;
    
    [marker setIcon:[UIImage imageNamed:@"marker"]];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[split[0] doubleValue]
                                                            longitude:[split[1] doubleValue]
                                                                 zoom:14];
    [mapView setCamera:camera];
    
    
    [self.tableView.tableFooterView addSubview:mapView];
 
    
    UnderMap *underMap = [[[NSBundle mainBundle] loadNibNamed:@"UnderMap" owner:self options:nil] objectAtIndex:0];
    underMap.addressLabel.text=[master objectForKey:@"address"];
    underMap.nameLabel.text=[master objectForKey:@"name"];
    underMap.frame=CGRectMake(0, self.height-400, self.width, 400);
    [tableView.tableFooterView addSubview:underMap];
    [underMap.workButton addTarget:nil action:@selector(toWorkTime) forControlEvents:UIControlEventTouchDown];
    [underMap.aboutButton addTarget:nil action:@selector(toAbout) forControlEvents:UIControlEventTouchDown];

    CGPoint newContentOffset = CGPointMake(0, 350);
    
    [self.tableView setContentOffset:newContentOffset animated:YES];


      // [self.tableView scrollRectToVisible:[self.tableView convertRect:CGRectMake(self.tableView.tableFooterView.bounds.origin.x, 0, self.tableView.tableFooterView.bounds.size.width, self.height)  fromView:self.tableView.tableFooterView] animated:YES];
    
    
}

-(void)addShadow
{
    if(self.shadow)
       [self.shadow removeFromSuperview];
    self.shadow=[[UIView alloc] initWithFrame:self.view.frame];
    [self.shadow setBackgroundColor:[UIColor blackColor]];
    self.shadow.alpha=0.6;
    [self.view addSubview:self.shadow];
}
-(void)detailInfo:(NSString *)text
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DetailInfo" bundle:nil];
    DetailInfoViewController *vc = (DetailInfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DetailInfoViewController"];
    vc.text=text;
    
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:NO completion:nil];
}
-(void)toAbout
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DetailInfo" bundle:nil];
    DetailInfoViewController *vc = (DetailInfoViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DetailInfoViewController"];
    NSString *text=[master objectForKey:@"about"];
    vc.text=text;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:NO completion:nil];
    
}
-(void)toWorkTime
{
    WorkTimeViewController *vc=[[WorkTimeViewController alloc] init];
    vc.work=[self.master objectForKey:@"hoursWork"];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:NO completion:nil];
}

-(void)openPhoto:(UITapGestureRecognizer*)tap
{
    
    ImageZoomViewer *zoomImageView = [[ImageZoomViewer alloc]initWithBottomCollectionBorderColor:[UIColor orangeColor]];
    [ zoomImageView.closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zoomImageView.delegate = self;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    CGPoint point = [self.view convertPoint:tap.view.frame.origin toView:appDelegate.window];
    CGRect animFrame = CGRectMake(point.x, point.y, tap.view.frame.size.width, tap.view.frame.size.height);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:animFrame];
    NSArray *images=[self.master objectForKey:@"files"];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:tap.view.tag]]];
    [zoomImageView showWithPageIndex:tap.view.tag andImagesCount:images.count withInitialImageView:imgView andAnimType:AnimationTypePop];
}

# pragma Mark - ImageZoomViewer Delegates

- (void)initializeImageviewWithImages:(UIImageView *)imageview withIndexPath:(NSIndexPath *)indexPath withCollection:(int)collectionReference
{
    NSArray *images=[self.master objectForKey:@"files"];
    NSString *urlString = [images objectAtIndex:indexPath.row];
    [imageview sd_setImageWithURL:[NSURL URLWithString:urlString]];
}

- (void)imageIndexOnChange:(NSInteger)index
{
    NSArray *images=[self.master objectForKey:@"files"];
    //[thumbImageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:index]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
