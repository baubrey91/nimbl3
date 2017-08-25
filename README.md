# nimbl3

## User Stories

The following functionality is completed:

- [x] Images - all handled through AFNetworking
   - [x] Loaded asynchronous
   - [x] Put in cache
   - [x] Low quality is loaded first then callback starts download for high quality
- [x] Data is repulled once app is re-opened with observer in appDelegate
- [x] Suvrvey API call can take inputs for page and page number
- [x] Title and description unwrap to next line if too large
- [x] Function written to get new token if needed
- [x] Survey is presented Modally (I think it looks nicer modally which is why I added another NavContorller)
- [x] Reachability framework checks if you are connected to the internet and sends warning if not
- [x] Simple icon and splash screen

## Notes

Overall I tried to keep the project as simple and easy to read as possible, but if you would like me to implement something more difficult I would be up for the challenge. UI is done in storyBoard. MVVM design pattern. I followed these practices for writing swift https://github.com/github/swift-style-guide.

Credit to icons8, AFNetworking, SVProgresshud, Reachability,

## License

    Copyright [2017] [Brandon aubrey]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.


