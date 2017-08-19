//
//  VTBaseBallot.m
//  Votem Example
//
//  Created by Matt on 8/16/17.
//  Copyright © 2017 Matt S Becker. All rights reserved.
//

#import "VTBallot.h"

NSString const *kVTBallotSelectionValueKey = @"selections";

@interface VTBallot()
@property(nonatomic, strong) NSMutableArray *mutableKeyValueObservers;
@end

@implementation VTBallot
@synthesize keyValueObservers = _keyValueObservers;

- (instancetype)init {
    self = [super init];
    self.submittable = NO;
    self.enabled = YES;
    return self;
}

- (void)selectOption:(VTBallotOption *)option {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ must be overridden by a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}

- (void)deselectOption:(VTBallotOption *)option {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ must be overridden by a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}

- (BOOL)evaluateSubmittable {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ must be overridden by a subclass", NSStringFromSelector(_cmd)] userInfo:nil];
}

- (void)addKeyValueObserver:(NSObject*)keyValueObserver {
    // If the mutableKeyValueObservers array hasn't been created, do so now
    if (!self.mutableKeyValueObservers) {
        self.mutableKeyValueObservers = [NSMutableArray array];
    }
    
    // Add the new observer to the mutable array
    [self.mutableKeyValueObservers addObject:keyValueObserver];
    
    // When we're done, set the keyValueObservers
    self.keyValueObservers = [NSArray arrayWithArray:self.mutableKeyValueObservers];
}

- (void)removeKeyValueObserver:(NSObject*)keyValueObserver {
    if (!self.keyValueObservers) {
        // Nothing to do!
        return;
    }
    
    // Remove this object from the mutable array
    [self removeObserver:keyValueObserver forKeyPath:@"selections"];
    [self.mutableKeyValueObservers removeObject:keyValueObserver];
    
    self.keyValueObservers = [NSArray arrayWithArray:self.mutableKeyValueObservers];
}

- (void)setKeyValueObservers:(NSArray *)keyValueObservers {
    _keyValueObservers = keyValueObservers;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selections"]) {
        // notify any observers that the selection has changed
        for (NSObject *observer in self.keyValueObservers) {
            [observer didChangeValueForKey:@"selections"];
        }
    }
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"selections"]) {
        return YES;
    }
    return NO;
}



@end
