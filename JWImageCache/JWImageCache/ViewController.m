//
//  ViewController.m
//  JWImageCache
//
//  Created by 郑建文 on 15/12/23.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+JWCache.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self test];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)test
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    NSLog(NSLocalizedStringFromTable(@"你好", @"JW Localizabled", nil));
    NSString *test = [[NSBundle bundleWithPath:path] localizedStringForKey:@"你好" value:nil table:@"JW Localizabled"];
    NSLog(@"%@", test);
}
- (IBAction)loadImage:(id)sender
{
    [self.image jw_setImageWithURL:[NSURL URLWithString:@""]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
