//
//  BeneficiariesViewController.swift
//  Beneficiaries
//
//  Created by Erik Perez on 3/12/24.
//

import UIKit

final class BeneficiariesViewController: UIViewController {
    
    // MARK: Properties
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .black
        return indicator
    }()
    
    private lazy var errorRetryView: ErrorRetryView = {
        let retryView = ErrorRetryView(onRetryAction: .init(handler: { [weak self] _ in
            self?.loadBeneficiaries()
        }))
        
        retryView.translatesAutoresizingMaskIntoConstraints = false
        retryView.isHidden = true
        return retryView
    }()
    
    private let noBeneficiariesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "There are no designated beneficiaries."
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 80
        table.delegate = self
        table.dataSource = self
        table.register(BeneficiaryTableViewCell.self,
                       forCellReuseIdentifier: BeneficiaryTableViewCell.identifier)
        return table
    }()

    let viewModel: BeneficiariesViewModelProtocol
    
    // MARK: Initialization
    
    init(viewModel: BeneficiariesViewModelProtocol = BeneficiariesViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Beneficiaries"
        view.backgroundColor = .white
        
        setUpTableView()
        setUpNoBeneficiariesLabel()
        setUpRetryView()
        setUpActivityIndicator()
        
        loadBeneficiaries()
    }
    
    // MARK: Methods
    
    func loadBeneficiaries() {
        errorRetryView.isHidden = true
        noBeneficiariesLabel.isHidden = true
        tableView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        Task { @MainActor in
            do {
                try await viewModel.loadBeneficiaries()
                
                activityIndicator.isHidden = true
                errorRetryView.isHidden = true
                tableView.isHidden = viewModel.beneficiaries.isEmpty
                noBeneficiariesLabel.isHidden = !viewModel.beneficiaries.isEmpty
                
                tableView.reloadData()
            } catch {
                tableView.isHidden = true
                activityIndicator.isHidden = true
                noBeneficiariesLabel.isHidden = true
                errorRetryView.isHidden = false
                
                if let beneficiariesError = error as? BeneficiariesViewModel.BeneficiariesViewModelError {
                    errorRetryView.title = beneficiariesError.description
                } else {
                    errorRetryView.title = "Unexpected error occurred. Please try again."
                }
            }
        }
    }
    
    // MARK: Setup
    
    private func setUpTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setUpRetryView() {
        view.addSubview(errorRetryView)
        
        NSLayoutConstraint.activate([
            errorRetryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            errorRetryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            errorRetryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            errorRetryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setUpNoBeneficiariesLabel() {
        view.addSubview(noBeneficiariesLabel)
        
        let horizontalPadding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            noBeneficiariesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, 
                                                          constant:  horizontalPadding),
            noBeneficiariesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, 
                                                           constant: -horizontalPadding),
            noBeneficiariesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            noBeneficiariesLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.backgroundColor = .lightGray
        activityIndicator.layer.cornerRadius = 15
        
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - UITableViewDatasource

extension BeneficiariesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.beneficiaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeneficiaryTableViewCell.identifier, 
                                                 for: indexPath) as! BeneficiaryTableViewCell
        
        if viewModel.beneficiaries.indices.contains(indexPath.row) {
            cell.configure(with: viewModel.beneficiaries[indexPath.row])
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension BeneficiariesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard viewModel.beneficiaries.indices.contains(indexPath.row) else {
            return
        }
        
        let detailsViewModel = BeneficiaryDetailsViewModel(beneficiary: viewModel.beneficiaries[indexPath.row])
        navigationController?.pushViewController(BeneficiaryDetailsViewController(viewModel: detailsViewModel), animated: true)
    }
}
