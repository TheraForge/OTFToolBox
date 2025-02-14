/*
Copyright (c) 2024, Hippocrates Technologies Sagl. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of the copyright holder(s) nor the names of any contributor(s) may
be used to endorse or promote products derived from this software without specific
prior written permission. No license is granted to the trademarks of the copyright
holders even if such marks are included in this software.

4. Commercial redistribution in any form requires an explicit license agreement with the
copyright holder(s). Please contact support@hippocratestech.com for further information
regarding licensing.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
OF SUCH DAMAGE.
 */

import Foundation

/**
 * Encryption Modes allowed at present.
 *
 * @param RunToCompletionWithin10Seconds Apps are guaranteed to complete syncing within 10 seconds, it will set NSFileProtectionType to CompleteUnlessOpen till 10 seconds finishes. After 10 seconds it will be change to NSFileProtectionType to Complete automatically and any running syncing won't be able to access Files if application is in background.
 *
 * @param RunToCompletionBeyond10Seconds Apps cannot complete syncing within 10 seconds and need more time, RunToCompletionBeyond10Seconds will give 20 seconds timeframe to finish any running syncing. After 20 seconds it will be change to NSFileProtectionType to Complete automatically and any running syncing won't be able to access Files if application is in background.
 *
 * @param BackgroundMode Apps need to periodically run in the background to do things such as automatic syncs. It will give 30 seconds timeframe to finish any operation  in the background. After 30 seconds it will be change to NSFileProtectionType to Complete automatically and any running operation won't be able to access Files because application is in background.
 *
*/

@objc public enum OTFProtectionLevel: Int {
    case runToCompletionWithIn10Seconds = 10
    case runToCompletionBeyond10Seconds = 20
    case backgroundMode = 30
}

