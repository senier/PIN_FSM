obj/main: generated/rflx.ads
	gprbuild -P pin

generate: generated/rflx.ads

generated/rflx.ads: pin_fsm.rflx .FORCE
	mkdir -p generated
	rflx generate -d generated $<
	rflx graph -d generated $<

clean:
	rm -rf obj

.FORCE:
