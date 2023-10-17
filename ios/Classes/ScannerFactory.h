#import <Flutter/Flutter.h>
#import "ScannerView.h"

@interface ScannerFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar;
@end


@interface ScannerController : NSObject <FlutterPlatformView>
@property(strong, nonatomic) ScannerView *scannerView;

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject <FlutterPluginRegistrar> *)registrar;
@end