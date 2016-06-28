//
//  MotionKit.h
//  Motion
//
//  Created by Aries on 16/6/27.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>


@protocol MotionKitDelegate <NSObject>

@optional
-(void)retrieveAccelerometerValuesX:(double)x y:(double)y z:(double)z absoluteValue:(double)absoluteValue;
-(void)retrieveGyroscopeValuesX:(double)x y:(double)y z:(double)z absoluteValue:(double)absoluteValue;
-(void)retrieveDeviceMotionObject:(CMDeviceMotion *)deviceMotion;
-(void)retrieveMagnetometerValuesX:(double)x y:(double)y z:(double)z absoluteValue:(double)absoluteValue;

-(void)getAccelerationValFromDeviceMotionX:(double)x y:(double)y z:(double)z;
-(void)getGravityAccelerationValFromDeviceMotionX:(double)x y:(double)y z:(double)z;
-(void)getRotationRateFromDeviceMotionX:(double)x y:(double)y z:(double)z;
-(void)getMagneticFieldFromDeviceMotionX:(double)x y:(double)y z:(double)z;
-(void)getAttitudeFromDeviceMotion:(CMAttitude *)attitude;

@end
@interface MotionKit : NSObject

@property (nonatomic, strong) CMMotionManager *manager;
@property (nonatomic, assign) id<MotionKitDelegate>delegate;

-(void)getAccelerometerValues:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values;
-(void)getGyroValues:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values;
-(void)getMagnetometerValues:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values;

//CMDeviceMotion
-(void)getDeviceMotionObject:(NSTimeInterval)interval values:(void(^)(CMDeviceMotion *deviceMotion))values;
-(void)getAccelerationFromDeviceMotion:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values;
-(void)getGravityAccelerationFromDeviceMotion:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values;
-(void)getAttitudeFromDeviceMotion:(NSTimeInterval)interval values:(void(^)(CMAttitude *attitude))values;
-(void)getRotationRateFromDeviceMotion:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values;
-(void)getMagneticFieldFromDeviceMotion:(NSTimeInterval)interval values:(void(^)( double x, double y, double z, int accuracy))values;

//Getting just a single value at an instant
-(void)getAccelerationAtCurrentInstant:(void(^)( double x, double y, double z))values;
-(void)getGravitationalAccelerationAtCurrentInstant:(void(^)( double x, double y, double z))values;
-(void)getAttitudeAtCurrentInstant:(void(^)(CMAttitude *attitude))values;
-(void)getMageticFieldAtCurrentInstant:(void(^)( double x, double y, double z))values;
-(void)getGyroValuesAtCurrentInstant:(void(^)( double x, double y, double z))values;

-(void)stopAccelerometerUpdates;
-(void)stopGyroUpdates;
-(void)stopDeviceMotionUpdates;
-(void)stopmagnetometerUpdates;

@end
