# stonepath
State-based workflow for rails.


## What is Stonepath?
Stonepath is the name of a workflow modeling methodology pioneered in applications written in the late 1990's and early 2000's for the U.S. State Department to support import/export control in the Former Soviet Union Countries.

Stonepath has since been refined in several dozen applications for Government and commercial clients.

## Whats all this code?
Stonepath was *also* the name of a gem implementing Stonepath as a domain-specific-language on top of ActiveRecord.

## *Was* a gem?
ActiveRecord maps to the Stonepath convention very well (see some of the included docs).  So well, in fact, several of us at CodeSherpas experimentd with building a DSL that mapped ActiveRecord concepts to the Stonepath terminology.  for instance the Stonepath concept of a Workitem 'Owner' maps to 'belongs_to :user' very well.

But ActiveRecord changed considerably between the many versions of rails since it was written, and maintaining it seemed more trouble that it was worth;  it became easier just to teach the workflow concepts and use ActiveRecord for what it was intended for, rather than maintain a domain-specific-language that ultimately was just a layer between you and your code that got in the way while debugging.


## Ok, so How can I learn Stonepath?

First, check out the docs also in this repository, and check out all the workflow entries on https://blog.codesherpas.com.

I've been threatening for some time to compile all of this knowledge into a book about modeling workflow for backoffice application in Rails.  If you'd like to see something like that, please reach out and convince me to make it happen.



## LICENSE:

(The MIT License)

Copyright (c) 2014 David Bock

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.