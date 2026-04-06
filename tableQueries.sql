CREATE TABLE Bids ( 
    bid_id INT PRIMARY KEY AUTO_INCREMENT, 
    job_id INT NOT NULL, 
    freelancer_id INT NOT NULL, 
    bid_amount DECIMAL(10,2) NOT NULL CHECK (bid_amount > 0), 
    status ENUM('Pending', 'Accepted', 'Rejected') DEFAULT 'Pending', 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 
    CONSTRAINT fk_bid_job  
        FOREIGN KEY (job_id) REFERENCES Jobs(job_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
 
    CONSTRAINT fk_bid_freelancer  
        FOREIGN KEY (freelancer_id) REFERENCES Freelancers(freelancer_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
         
    CONSTRAINT unique_bid UNIQUE (job_id, freelancer_id) 
); 


CREATE TABLE Contracts ( 
    contract_id INT PRIMARY KEY AUTO_INCREMENT, 
    job_id INT NOT NULL, 
    client_id INT NOT NULL, 
    freelancer_id INT NOT NULL, 
    start_date DATE NOT NULL, 
    end_date DATE, 
     
    status ENUM('Active', 'Completed', 'Cancelled') DEFAULT 'Active', 
     
    CONSTRAINT fk_contract_job  
        FOREIGN KEY (job_id) REFERENCES Jobs(job_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
         
    CONSTRAINT fk_contract_client  
        FOREIGN KEY (client_id) REFERENCES Clients(client_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
         
    CONSTRAINT fk_contract_freelancer  
        FOREIGN KEY (freelancer_id) REFERENCES Freelancers(freelancer_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE, 
         
    CONSTRAINT chk_dates CHECK (end_date IS NULL OR end_date >= 
start_date), 
     
    CONSTRAINT unique_active_contract UNIQUE (job_id, freelancer_id) 
);
-- Indexes for Bids
CREATE INDEX idx_bids_job ON Bids(job_id);
CREATE INDEX idx_bids_freelancer ON Bids(freelancer_id);

-- Indexes for Contracts
CREATE INDEX idx_contracts_job ON Contracts(job_id);
CREATE INDEX idx_contracts_client ON Contracts(client_id);
CREATE INDEX idx_contracts_freelancer ON Contracts(freelancer_id);
-- This file contains queries for table creation
