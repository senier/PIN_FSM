obj/main: obj/generated/rflx.ads
	gprbuild -P pin

obj/generated/rflx.ads: pin_fsm.rflx
	mkdir -p obj/generated
	rflx generate -d obj/generated $<

clean:
	rm -rf obj
