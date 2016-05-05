# strict.bash

For those times when you find yourself old and grumpy, while others reinvent bash debugging...

Have a look at the [./example](./example) for usage and take it for a spin:

## Output of `./example`:

```
$ false || true
$ false

--------------------------------------------------------------------------------
EXIT with 1
+(/Users/andrei/tmp/strict.bash/strict.bash:15): false
```

## Output of `./example` when interrupting with `CTRL-C`:
```
$ false || true
^C
--------------------------------------------------------------------------------
INT with 130
+(./example:1): main(): sleep 5

--------------------------------------------------------------------------------
EXIT with 130
+(./example:1): main(): sleep 5
```

## Output of `SHELLOPTS=xtrace ./example`:

```
+(./example:11): main(): exe 'false || true'
+(/Users/andrei/git/strict.bash/strict.bash:39): exe(): EXE_COMMAND='false || true'
+(/Users/andrei/git/strict.bash/strict.bash:40): exe(): eval 'echo "$ false || true"; false || true'
++(/Users/andrei/git/strict.bash/strict.bash:40): exe(): echo '$ false || true'
$ false || true
++(/Users/andrei/git/strict.bash/strict.bash:40): exe(): false
++(/Users/andrei/git/strict.bash/strict.bash:40): exe(): true
+(/Users/andrei/git/strict.bash/strict.bash:41): exe(): unset EXE_COMMAND
+(./example:12): main(): false
+(./example:12): main(): true
+(./example:14): main(): sleep 5
+(./example:15): main(): exe false
+(/Users/andrei/git/strict.bash/strict.bash:39): exe(): EXE_COMMAND=false
+(/Users/andrei/git/strict.bash/strict.bash:40): exe(): eval 'echo "$ false"; false'
++(/Users/andrei/git/strict.bash/strict.bash:40): exe(): echo '$ false'
$ false
++(/Users/andrei/git/strict.bash/strict.bash:40): exe(): false
+(/Users/andrei/git/strict.bash/strict.bash:1): exe(): TRAP_SIGNAL=EXIT
+(/Users/andrei/git/strict.bash/strict.bash:1): exe(): TRAP_CODE=1
+(/Users/andrei/git/strict.bash/strict.bash:1): exe(): TRAP_LOCATION='+(/Users/andrei/git/strict.bash/strict.bash:1): exe(): '
+(/Users/andrei/git/strict.bash/strict.bash:1): exe(): TRAP_COMMAND=false
+(/Users/andrei/git/strict.bash/strict.bash:1): exe(): on_trap
+(/Users/andrei/git/strict.bash/strict.bash:29): on_trap(): set +x

--------------------------------------------------------------------------------
EXIT with 1
+(/Users/andrei/git/strict.bash/strict.bash:1): exe(): false
```

## Output of `SHELLOPTS=xtrace ./example 5>/dev/null`:

Identical with `./example` as `$BASH_XTRACEFD` is set to default to `5`.

## License

[Unlicense](LICENSE).
