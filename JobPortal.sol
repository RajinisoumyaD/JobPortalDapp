// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract JobPortal{
    address public admin;

    constructor() {
        admin = msg.sender;
    }
    struct Applicant {
        string name;
        uint age;
        string Address;
        uint rating;

    }

    mapping (uint =>Applicant) public applicants;
    uint public lastApplicantId;

    modifier onlyAdmin(){
        require(msg.sender == admin, "only admin can perform this operation");
        _;

    }    
    function addApplicant (
        string memory _name,
        uint _age,
        string memory _address
        //string memory _reqjob 
) public onlyAdmin{
        lastApplicantId++;
        applicants[lastApplicantId] = Applicant({
            name: _name,
            age: _age,
            Address:_address,
            rating : 0
        });
    }
    function getApplicantDetails(
        uint _applicantId
    ) public view returns (Applicant memory) {
        require(
            _applicantId <= lastApplicantId,
            "Applicant with the given ID does not exist"
        );
        return applicants[_applicantId];
    }

    function getApplicantType(
        uint _applicantId
    ) public pure returns (string memory) {
        // Simplified logic to determine applicant type based on the applicant ID
        if (_applicantId % 2 == 0) {
            return "Type A";
        } else {
            return "Type B";
        }
    }

    struct Job {
        string jobName;
        uint salary;
        string details;
        uint applicantsCount;
    }

    mapping(string => Job) public jobs;

    function addJob(
        string memory _jobName,
        uint _salary,
        string memory _details
    ) public onlyAdmin {
        jobs[_jobName] = Job({
            jobName: _jobName,
            salary: _salary,
            details: _details,
            applicantsCount: 0
        });
    }

    function getJobDetails(
        string memory _jobName
    ) public view returns (Job memory) {
        return jobs[_jobName];
    }

    function applyForJob(uint _applicantId, string memory _jobName) public {
        require(
            _applicantId <= lastApplicantId,
            "Applicant with the given ID does not exist"
        );
        require(
            bytes(jobs[_jobName].jobName).length != 0,
            "Job with the given name does not exist"
        );

        jobs[_jobName].applicantsCount++;
    }

    function provideRating(uint _applicantId, uint _rating) public onlyAdmin {
        require(
            _applicantId <= lastApplicantId,
            "Applicant with the given ID does not exist"
        );
        require(
            _rating >= 1 && _rating <= 5,
            "Invalid rating. Ratings must be between 1 and 5"
        );

        applicants[_applicantId].rating = _rating;
    }

    function getApplicantRating(uint _applicantId) public view returns (uint) {
        require(
            _applicantId <= lastApplicantId,
            "Applicant with the given ID does not exist"
        );
        return applicants[_applicantId].rating;
    }
            
}
    
    


