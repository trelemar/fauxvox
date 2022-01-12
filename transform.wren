foreign class Transform {
	construct init() {}
	construct initFromFile(path) {
		f_loadFromFile(path)
	}
	foreign f_loadFromFile(path)

	static loadFromFile(path) {
		return Transform.initFromFile(path)
	}
	
	foreign width
	foreign height

	foreign draw(x, y)
	foreign rdraw(x, y, map)
}

foreign class Stack {
	construct init() {}
	construct init(path, sliceWidth, sliceHeight) {
		f_new(path, sliceWidth, sliceHeight)
	}
	foreign f_new(path, sliceWidth, sliceHeight)

	static new(path, sliceWidth, sliceHeight) {
		return Stack.init(path, sliceWidth, sliceHeight)
	}
	//foreign draw(x, y, angle, scaleY, sliceOffset)

	//foreign draw(x, y, angle, pitch)

	foreign drawp(x, y, angle, squash, frame)

	drawp(x, y, angle, squash) {
		drawp(x, y, angle, squash, 0)
	}

	draw(x, y, angle) {
		draw(x, y, angle, 1, 1)
	}
}