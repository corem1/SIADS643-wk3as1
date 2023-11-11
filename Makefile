all: artifacts/model.pkl

artifacts/combined.csv: permits_combine.py
	mkdir -p artifacts
	python permits_combine.py input_data/ artifacts/combined.csv

artifacts/clean.csv: artifacts/combined.csv permits_clean.py
	python permits_clean.py artifacts/combined.csv artifacts/clean.csv

artifacts/model.pkl: artifacts/clean.csv permits_train.py
	python permits_train.py artifacts/clean.csv artifacts/model.pkl

.PHONY: clean all

clean:
	rm -f artifacts/combined.csv
	rm -f artifacts/clean.csv

clean-all: clean
	rm -f artifacts/model.pkl