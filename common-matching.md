[TOC]

#### Matching repeated characters

```
(.)\1{3,}
```
#### Matching an email
```
([a-z0-9_\.-]+)@([a-z0-9\.=]+)\.([a-z\.]{2,6})
```
#### Matching an url
```
(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?
```
#### Matching list of words
```
\b\(one\|two\|three\)\b
```
#### Lookaround (Lookahead and Lookbehind)
