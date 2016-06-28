//
//  MotionKit.m
//  Motion
//
//  Created by Aries on 16/6/27.
//  Copyright © 2016年 Aries. All rights reserved.
//

#import "MotionKit.h"

@implementation MotionKit
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"MotionKit has been initialised successfully");
    }
    return self;
}
-(void)getAccelerometerValues:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values{
    if(interval <= 0){
        interval = 0.1;
    }
    if([self.manager isAccelerometerAvailable]){
        self.manager.accelerometerUpdateInterval = interval;
        [self.manager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            if(error){
                NSLog(@"Error:%@",error);
            }
            double valX = accelerometerData.acceleration.x;
            double valY = accelerometerData.acceleration.y;
            double valZ = accelerometerData.acceleration.z;
            
            if(values){
                values(valX,valY,valZ);
            }
            
            double absoluteVal = sqrt(valX * valX + valY * valY + valZ * valZ);
            if(self.delegate && [self.delegate respondsToSelector:@selector(retrieveAccelerometerValuesX:y:z:absoluteValue:)]){
                [self.delegate retrieveAccelerometerValuesX:valX y:valY z:valZ absoluteValue:absoluteVal];
            }
            
        }];
    }else{
        NSLog(@"The Accelerometer is not available");
    }
}

-(void)getGyroValues:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values{
    if(interval <= 0){
        interval = 0.1;
    }
    if(self.manager.gyroAvailable){
        self.manager.gyroUpdateInterval = interval;
        [self.manager startGyroUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            if(error){
                NSLog(@"Error:%@",error);
            }
            
            double valX = gyroData.rotationRate.x;
            double valY = gyroData.rotationRate.y;
            double valZ = gyroData.rotationRate.z;
            
            if(values){
                values(valX,valY,valZ);
            }
            double absoluteVal = sqrt(valX * valX + valY * valY + valZ * valZ);
            if(self.delegate && [self.delegate respondsToSelector:@selector(retrieveGyroscopeValuesX:y:z:absoluteValue:)]){
                [self.delegate retrieveGyroscopeValuesX:valX y:valY z:valZ absoluteValue:absoluteVal];
            }
        }];
    }else{
        NSLog(@"The Gyroscope is not available");
    }
}

-(void)getMagnetometerValues:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values{
    if(interval <= 0){
        interval = 0.1;
    }
    if(self.manager.magnetometerAvailable){
        self.manager.magnetometerUpdateInterval = interval;
        [self.manager startMagnetometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
            if(error){
                NSLog(@"Error:%@",error);
            }
            
            double valX = magnetometerData.magneticField.x;
            double valY = magnetometerData.magneticField.y;
            double valZ = magnetometerData.magneticField.z;
            
            if(values){
                values(valX,valY,valZ);
            }
            double absoluteVal = sqrt(valX * valX + valY * valY + valZ * valZ);
            if(self.delegate && [self.delegate respondsToSelector:@selector(retrieveMagnetometerValuesX:y:z:absoluteValue:)]){
                [self.delegate retrieveMagnetometerValuesX:valX y:valY z:valZ absoluteValue:absoluteVal];
            }

        }];
        
    }else{
        NSLog(@"The Gyroscope is not available");
    }

}
#pragma mark - DEVICE MOTION APPROACH STARTS HERE

-(void)getDeviceMotionObject:(NSTimeInterval)interval values:(void(^)(CMDeviceMotion *deviceMotion))values{
    if(interval <= 0){
        interval = 0.1;
    }
    if(self.manager.deviceMotionAvailable){
        self.manager.deviceMotionUpdateInterval = interval;
        [self.manager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init]
                                          withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                                              if(error){
                                                  NSLog(@"Error:%@",error);
                                              }
                                              if(values){
                                                  values(motion);
                                              }
                                              if(self.delegate && [self.delegate respondsToSelector:@selector(retrieveDeviceMotionObject:)]){
                                                  [self.delegate retrieveDeviceMotionObject:motion];
                                              }
                                          }];
    }else{
        NSLog(@"Device Motion is not available");
    }
}

-(void)getAccelerationFromDeviceMotion:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values{
    if(interval <= 0){
        interval = 0.1;
    }
    if(self.manager.deviceMotionAvailable){
        self.manager.deviceMotionUpdateInterval = interval;
        [self.manager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init]
                                          withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                                              if(error){
                                                  NSLog(@"Error:%@",error);
                                              }
                                              
                                              double valX = motion.userAcceleration.x;
                                              double valY = motion.userAcceleration.y;
                                              double valZ = motion.userAcceleration.z;
                                              
                                              if(values){
                                                  values(valX,valY,valZ);
                                                  
                                              }
                                              if(self.delegate && [self.delegate respondsToSelector:@selector(getAccelerationValFromDeviceMotionX:y:z:)]){
                                                  [self.delegate getAccelerationValFromDeviceMotionX:valX y:valY z:valZ];
                                              }
                                          }];

    }else {
        NSLog(@"Device Motion is unavailable");
    }
}

-(void)getGravityAccelerationFromDeviceMotion:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values{
    if(interval <= 0){
        interval = 0.1;
    }
    if(self.manager.deviceMotionAvailable){
        self.manager.deviceMotionUpdateInterval = interval;
        [self.manager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init]
                                          withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                                              if(error){
                                                  NSLog(@"Error:%@",error);
                                              }
                                              double valX = motion.gravity.x;
                                              double valY = motion.gravity.y;
                                              double valZ = motion.gravity.z;
                                              if(values){
                                                  values(valX,valY,valZ);
                                              }
                                              if(self.delegate && [self.delegate respondsToSelector:@selector(getGravityAccelerationValFromDeviceMotionX:y:z:)]){
                                                  [self.delegate getGravityAccelerationValFromDeviceMotionX:valX y:valY z:valZ];
                                              }
                                          }];
    }else{
        NSLog(@"Device Motion is not available");
    }

}

-(void)getAttitudeFromDeviceMotion:(NSTimeInterval)interval values:(void(^)(CMAttitude *attitude))values{
    if(interval <= 0){
        interval = 0.1;
    }
    if(self.manager.deviceMotionAvailable){
        self.manager.deviceMotionUpdateInterval = interval;
        [self.manager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init]
                                          withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                                              if(error){
                                                  NSLog(@"Error:%@",error);
                                              }
                                              
                                              if(values){
                                                  values(motion.attitude);
                                              }
                                              if(self.delegate && [self.delegate respondsToSelector:@selector(getAttitudeFromDeviceMotion:)]){
                                                  [self.delegate getAttitudeFromDeviceMotion:motion.attitude];
                                              }
                                          }];
    }else{
        NSLog(@"Device Motion is not available");
    }
    
}
-(void)getRotationRateFromDeviceMotion:(NSTimeInterval)interval values:(void(^)( double x, double y, double z))values{
    if(interval <= 0){
        interval = 0.1;
    }
    if(self.manager.deviceMotionAvailable){
        self.manager.deviceMotionUpdateInterval = interval;
        [self.manager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init]
                                          withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                                              if(error){
                                                  NSLog(@"Error:%@",error);
                                              }
                                              double valX = motion.rotationRate.x;
                                              double valY = motion.rotationRate.y;
                                              double valZ = motion.rotationRate.z;
                                              if(values){
                                                  values(valX,valY,valZ);
                                              }
                                              if(self.delegate && [self.delegate respondsToSelector:@selector(getRotationRateFromDeviceMotionX:y:z:)]){
                                                  [self.delegate getRotationRateFromDeviceMotionX:valX y:valY z:valZ];
                                              }
                                          }];
    }else{
        NSLog(@"Device Motion is not available");
    }

}

-(void)getMagneticFieldFromDeviceMotion:(NSTimeInterval)interval values:(void(^)( double x, double y, double z, int accuracy))values{
    if(interval <= 0){
        interval = 0.1;
    }
    if(self.manager.deviceMotionAvailable){
        self.manager.deviceMotionUpdateInterval = interval;
        [self.manager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init]
                                          withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                                              if(error){
                                                  NSLog(@"Error:%@",error);
                                              }
                                              double valX = motion.magneticField.field.x;
                                              double valY = motion.magneticField.field.y;
                                              double valZ = motion.magneticField.field.z;
                                              int valAccuracy = motion.magneticField.accuracy;
                                              if(values){
                                                  values(valX,valY,valZ,valAccuracy);
                                              }
                                              if(self.delegate && [self.delegate respondsToSelector:@selector(getMagneticFieldFromDeviceMotionX:y:z:)]){
                                                  [self.delegate getMagneticFieldFromDeviceMotionX:valX y:valY z:valZ];
                                              }
                                          }];
    }else{
        NSLog(@"Device Motion is not available");
    }

}
#pragma mark - INSTANTANIOUS METHODS START HERE
-(void)getAccelerationAtCurrentInstant:(void(^)( double x, double y, double z))values{
    [self getAccelerationFromDeviceMotion:0.5 values:^(double x, double y, double z) {
        values(x,y,z);
        [self stopDeviceMotionUpdates];
    }];
}
-(void)getGravitationalAccelerationAtCurrentInstant:(void(^)( double x, double y, double z))values{
    [self getGravityAccelerationFromDeviceMotion:0.5 values:^(double x, double y, double z) {
        values(x,y,z);
        [self stopDeviceMotionUpdates];
    }];
}
-(void)getAttitudeAtCurrentInstant:(void(^)(CMAttitude *attitude))values{
    [self getAttitudeFromDeviceMotion:0.5 values:^(CMAttitude *attitude) {
        values(attitude);
        [self stopDeviceMotionUpdates];
    }];
}
-(void)getMageticFieldAtCurrentInstant:(void(^)( double x, double y, double z))values{
    [self getMagneticFieldFromDeviceMotion:0.5 values:^(double x, double y, double z, int accuracy) {
        values(x,y,z);
        [self stopDeviceMotionUpdates];
    }];
}
-(void)getGyroValuesAtCurrentInstant:(void(^)( double x, double y, double z))values{
    [self getRotationRateFromDeviceMotion:0.5 values:^(double x, double y, double z) {
        values(x,y,z);
        [self stopDeviceMotionUpdates];
    }];
}

#pragma mark - stop
-(void)stopAccelerometerUpdates{
    [self.manager stopAccelerometerUpdates];
    NSLog(@"Accelaration Updates Status - Stopped");
}
-(void)stopGyroUpdates{
    [self.manager stopGyroUpdates];
    NSLog(@"Gyroscope Updates Status - Stopped");
}

-(void)stopDeviceMotionUpdates{
    [self.manager stopDeviceMotionUpdates];
    NSLog(@"Device Motion Updates Status - Stopped");
}

-(void)stopmagnetometerUpdates{
    [self.manager stopMagnetometerUpdates];
    NSLog(@"Magnetometer Updates Status - Stopped");
}
@end
