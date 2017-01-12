# Create Flywheel Gear that can run functional_preprocessing
# This pipeline is created by FSL and AFNI software, it is normally used to preprocess the fMRI data

# Start with the miykael/nipype_advanced Environment
FROM miykael/nipype_advanced
MAINTAINER Long Qian <longqianad@pku.edu.cn>

# Install dependencies
RUN apt-get update \
    && apt-get install -y \
    zip \
    gzip \
    jq

# ADD the MNI template files into container

ADD https://github.com/mricenter/mri-templates/raw/master/1mm/ch2_1mm.nii ／tmp/
ADD https://github.com/mricenter/mri-templates/raw/master/2mm/T1_bet_2mm.nii ／tmp/
ADD https://github.com/mricenter/mri-templates/raw/master/3mm/T1_3mm.nii ／tmp/



# Make directory for flywheel spec (v0)
ENV FLYWHEEL /flywheel/v0
RUN mkdir -p ${FLYWHEEL}


# Copy and configure run script and metadata code
COPY run ${FLYWHEEL}/run
RUN chmod +x ${FLYWHEEL}/run
COPY manifest.json ${FLYWHEEL}/manifest.json
ADD https://raw.githubusercontent.com/scitran/utilities/daf5ebc7dac6dde1941ca2a6588cb6033750e38c/metadata_from_gear_output.py ${FLYWHEEL}/metadata_create.py
RUN chmod +x ${FLYWHEEL}/metadata_create.py


# Configure entrypoint
ENTRYPOINT ["/flywheel/v0/run"]
