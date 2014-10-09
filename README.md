# Jekyll Blog

This one is really cool. First, build the image if you haven't already then run it. All you need to do to run is connect the right directory to a volume and name it:

```
$ docker run -v /path/to/blog:/data isinn/jekyll --name blog
```

Now run an apache image that is set to serve files from /var/www/html and has a volume at that same directory:

```
$ docker run -dP --volumes-from blog --name apache isinn/apache
```

## Updating

Here is the cool part. Running the jekyll image will only last a second because all it does is build the jekyll site and exit. Since it automatically runs the jekyll build command, all we need to do is start it again:

```
$ docker start blog
```

Now reload the blog in your browser and you will see the updates.
