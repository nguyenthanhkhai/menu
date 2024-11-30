#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <notify.h>
#import "SCLAlertView/SCLAlertView.h"

// Khai báo hàm didFinishLaunching trước khi sử dụng
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info);

// Hàm khởi tạo được gọi khi tweak được tải vào bộ nhớ
static void __attribute__((constructor)) initialize() {
    CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}

// Hàm cài đặt menu
static void setupMenu() {
    // Thực hiện cài đặt menu ở đây
}

// Hàm đặt hẹn giờ
static void timer(NSTimeInterval duration, void (^block)(void)) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

// Hàm xử lý sự kiện khi ứng dụng khởi chạy
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
    // Sử dụng hàm timer để chờ 5 giây trước khi hiển thị alert
    timer(2, ^{
        // Tạo một instance của SCLAlertView
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        
        // Thêm nút "Ghé Thăm!" và liên kết tới một website
        [alert addButton:@"FaceBook Contact!" actionBlock:^{
            // Mở URL khi người dùng nhấn vào nút "Ghé Thăm!"
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/hung.nguyen9905?mibextid=eQY6cl"]];
            // Sau 2 giây, gọi hàm setupMenu()
            timer(2, ^{
                setupMenu();
            });
        }];
        
        // Thêm nút "Liên Hệ Sau" để đóng alert
        [alert addButton:@"Liên Hệ Sau" actionBlock:^{
            // Sau 2 giây, gọi hàm setupMenu()
            timer(2, ^{
                setupMenu();
            });
        }];
        
        // Cấu hình alert
        alert.shouldDismissOnTapOutside = NO;
        alert.customViewColor = [UIColor purpleColor];
        alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;
        
        // Hiển thị alert
        [alert showSuccess:nil
                  subTitle:@"CYLIGHT TEAM VIETNAM \n\n Chúc Các Bạn Chơi Game Vui Vẻ, Thuê API Sever Key Liên Hệ \n\nZalo ConTact 0585.798.798!"
        closeButtonTitle:nil
                duration:99999999.0f];
    });
}
