### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 21b1f4b6-2172-4292-8249-35a615db4f59
begin    
    using Pkg
	Pkg.activate(mktempdir())
	# Pkg.add("Revise");using Revise
	Pkg.add("PlutoUI")
	using PlutoUI
	Pkg.add(name="PlutoCanvasPlot",version="0.0.5")
#	Pkg.develop("PlutoCanvasPlot")
	using PlutoCanvasPlot

end

# ╔═╡ c54da25c-0dbf-41d1-bd7f-657b115bf6bf
md"""
Test Notebook for [PlutoCanvasPlot](https://github.com/j-fu/PlutoCanvasPlot.jl)

So far, this package is in an early state. The current version  of the code is available via the registry `https://github.com/j-fu/PackageNursery.git` .

So, in order to run this notebook, you need to add this registry to you Julia environment.

```
pkg> registry add https://github.com/j-fu/PackageNursery.jl.git
```

This step can be safely undone by removing `.julia/registries/PackageNursery` in your
Julia folder.


"""

# ╔═╡ 825f6068-0f02-44e4-b083-1be3eb4c764d
let
	X=0:0.1:10
	p=CanvasPlot(;xrange=X,yrange=-1:1,resolution=(600,200))
	polyline!(p,X,sin.(X))
	polyline!(p,X,cos.(X))
    p
end

# ╔═╡ 2a5510d3-7355-4095-ab43-ad6d75bba090
let 
	p=CanvasPlot(resolution=(600,300))
	
	axis!(p; xtics=(0:2.5:10),ytics=(-1:0.5:1))
	X=0:0.1:10
	linecolor!(p,1,0,0)
   	polyline!(p,X,sin.(X))
	linecolor!(p,0,1,0)
	polyline!(p,X,cos.(X))
end

# ╔═╡ 405b81de-3fd9-48f7-81a7-dc8f06dfda9c
let 
	p=CanvasPlot(resolution=(300,300),xrange=-1:1,yrange=-1:1)
	T=0:0.01:2π
	X=0.45.*sin.(T)
	Y=0.45.*cos.(T)
	fillcolor!(p,0,1,0)
	polygon!(p,X,Y)
end

# ╔═╡ 83c16003-8196-4f2c-a602-c298f27475fb
begin
	@bind clock_t Clock(interval=0.01)
end

# ╔═╡ fd7c959b-94d6-43ff-b535-49b0883874d5
let 
	p=CanvasPlot(resolution=(300,300),xrange=-1:1,yrange=-1:1)
	time=0.005*clock_t
	dt=0.01
    T=time:dt:2π/2+time	
	px=5+sin(time/10)
	py=6+cos(time/10)
	X=sin.(px .*T)
	Y=cos.(py .*T)
	polyline!(p,X,Y)
end

# ╔═╡ Cell order:
# ╟─c54da25c-0dbf-41d1-bd7f-657b115bf6bf
# ╠═21b1f4b6-2172-4292-8249-35a615db4f59
# ╠═825f6068-0f02-44e4-b083-1be3eb4c764d
# ╠═2a5510d3-7355-4095-ab43-ad6d75bba090
# ╠═405b81de-3fd9-48f7-81a7-dc8f06dfda9c
# ╟─83c16003-8196-4f2c-a602-c298f27475fb
# ╠═fd7c959b-94d6-43ff-b535-49b0883874d5
