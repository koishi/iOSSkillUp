//
//  ViewController.m
//  iOS Education
//
//  Created by Minami Kyohei on 2016/07/13.
//  Copyright © 2016年 Minami Kyohei. All rights reserved.
//

#import "ViewController.h"
#import "Square.h"
#import "Reak.h"
#import "ModalViewController.h"

@interface ViewController ()
- (IBAction)ModalAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*** init ***/
    Square *square = [[Square alloc ]init];
    NSLog(@"%f", square.width);
    self.label.text = [NSString stringWithFormat:@"%f", square.width];
    
    /*** strong, weak***/
    // こんにちはを元から持ったstrongStrを生成
    __strong NSString *strongStr1 = [[NSString alloc] initWithFormat:@"こんにちは"];
    // strongStrのポインタを代入
    __weak NSString *weakStr1 = strongStr1;
    NSLog(@"strong:%@ / weak:%@", strongStr1, weakStr1);
    
    // 新たにポインタをセット
    strongStr1 = [[NSString alloc] initWithFormat:@"こんばんは"];
    // 解放される
    NSLog(@"strong:%@ / weak:%@", strongStr1, weakStr1);
    
    // リファレンスカウンタがカウントされる
    __strong NSString *strongStr2 = @"こんにちは";
    // ”こんにちは"のポインタを代入
    __weak NSString *weakStr2 = strongStr2;
    NSLog(@"storng:%@ / weak:%@", strongStr2, weakStr2);
    
    strongStr2 = @"こんばんは";
    // weakは"こんにちは"のポインタを参照している
    NSLog(@"storng:%@ / weak:%@", strongStr2, weakStr2);
    
    // メモリリーク発生参照の循環
    Reak *friend1 = [Reak new];
    Reak *friend2 = [Reak new];
    [friend1 setFriend: friend2];
    [friend2 setFriend: friend1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    // 通知の受信
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(dismissModalCall) name:@"Call" object:nil];
}

//通知を受信したときに呼び出されるメソッド
- (void)dismissModalCall
{
    NSLog(@"通知を受信しました");
}

- (IBAction)ModalAction:(id)sender {
    [self showModalView];
}

//　Modalで遷移
-(void)showModalView{
     ModalViewController *modalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    [self presentViewController:modalViewController animated:YES completion:nil];
}

@end