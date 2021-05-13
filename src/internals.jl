
"""
Set new world coordinates and calculate transformation data
"""
function _world!(p,xmin,xmax,ymin,ymax)
    p.xmin=xmin
    p.xmax=xmax
    p.ymin=ymin
    p.ymax=ymax
    p.ax= p.w/(p.xmax-p.xmin);
    p.ay=-p.h/(p.ymax-p.ymin);
    p.bx=0   - p.ax *p.xmin;
    p.by=p.h - p.ay *p.ymin;
    _initran2d!(p)
    nothing
end

"""
Transform a pair of coordinates from world to canvas
"""
_tran2d(p,x,y)=(x*p.ax+p.bx,y*p.ay+p.by)

"""
    _command!(p::CanvasPlot,cmd)

Enter new command named `cmd`.

The idea is to pass one single Dict
with all plot data to javascript.

For this purpose we need a some "language".

Plot elements are described by commands executed
one after another. For this purpose, we use 
integers converted to strings as dict keys and pass the command
name as the corresponding entry.

The entry `cmdcount` keeps track of the number of
commands. So we can parse all commands from 1 to jsdict[:cmdcount]
in javascript in the same sequence as they have been entered.

Parameters are named and entered into the dictionary with the 
command number as prefix.

E.g. for a polyline as command number 5, we create the entres

```
"5" => "polyline"
"5_x" => Vector of x coordinates in canvas coordinate system
"5_y" => Vector of y coordinates in canvas coordinate system
"""
function _command!(p::CanvasPlot,cmd)
    p.jsdict["cmdcount"]=p.jsdict["cmdcount"]+1
    pfx=string(p.jsdict["cmdcount"])
    p.jsdict[pfx]=cmd
    pfx
end


"""
Pass pair of coordinate arrays for `lines!`,`polyline!`,`polygon!`  
"""
function _poly!(p::CanvasPlot,cmd,x,y)
    pfx=_command!(p,cmd)
    
    tx=Vector{Float32}(undef,length(x))
    ty=Vector{Float32}(undef,length(y))
    for i=1:length(x)
        tx[i],ty[i]=_tran2d(p,x[i],y[i])
    end
    p.jsdict[pfx*"_x"]=tx
    p.jsdict[pfx*"_y"]=ty
    p
    
end

