rm -r docs
haxe docs.hxml
haxelib run dox -in stx.* --exclude stx.Tuple2 --exclude stx.Tup2  --exclude stx.Tup* -o docs -i docs.xml
